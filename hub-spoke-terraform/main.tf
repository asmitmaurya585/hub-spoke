module "resource_group" {
  source  = "./modules/azurerm_resource_group"
  asmitrg = var.asmitrg
}

locals {
  hub_config    = var.topology.hub
  spokes_config = var.topology.spokes
}

module "hub" {
  source = "./modules/hub"

  resource_group_name = coalesce(local.hub_config.name, local.hub_config.resource_group)
  location            = local.hub_config.location
  vnet_name           = "vnet-hub"
  address_space       = local.hub_config.address_space
  subnets             = local.hub_config.subnets
  tags                = merge(var.tags, try(local.hub_config.tags, {}))
}

import {
  to = module.hub.azurerm_network_security_group.bastion_nsg[0]
  id = "/subscriptions/0b430b86-4372-414d-a228-fbc54442f4eb/resourceGroups/rg-hub/providers/Microsoft.Network/networkSecurityGroups/nsg-hub-azurebastionsubnet"
}

module "spokes" {
  for_each = local.spokes_config

  source = "./modules/spoke"

  spoke_key           = each.key
  resource_group_name = coalesce(each.value.name, each.value.resource_group)
  location            = each.value.location
  vnet_name           = "vnet-spoke-${each.key}"
  address_space       = each.value.address_space
  subnets             = each.value.subnets
  tags                = merge(var.tags, try(each.value.tags, {}))
}

module "peerings" {
  for_each = local.spokes_config

  source = "./modules/peering"

  peering_name_hub_to_spoke = "peer-hub-to-spoke-${each.key}"
  peering_name_spoke_to_hub = "peer-spoke-${each.key}-to-hub"

  hub_resource_group_name = module.hub.resource_group_name
  hub_vnet_name           = module.hub.vnet_name
  hub_vnet_id             = module.hub.vnet_id

  spoke_resource_group_name = module.spokes[each.key].resource_group_name
  spoke_vnet_name           = module.spokes[each.key].vnet_name
  spoke_vnet_id             = module.spokes[each.key].vnet_id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}
