resource "azurerm_resource_group" "spoke" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "spoke" {
  name                = var.vnet_name
  location            = azurerm_resource_group.spoke.location
  resource_group_name = azurerm_resource_group.spoke.name
  address_space       = var.address_space
  tags                = var.tags
}

resource "azurerm_subnet" "subnets" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = azurerm_resource_group.spoke.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = each.value
}

resource "azurerm_network_security_group" "nsg" {
  for_each            = var.subnets
  name                = "nsg-spoke-${var.spoke_key}-${each.key}"
  location            = azurerm_resource_group.spoke.location
  resource_group_name = azurerm_resource_group.spoke.name
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  for_each                  = azurerm_network_security_group.nsg
  subnet_id                 = azurerm_subnet.subnets[each.key].id
  network_security_group_id = each.value.id
}

resource "azurerm_route_table" "spoke" {
  name                          = "rt-spoke-${var.spoke_key}"
  location                      = azurerm_resource_group.spoke.location
  resource_group_name           = azurerm_resource_group.spoke.name
  bgp_route_propagation_enabled = true
  tags                          = var.tags
}

resource "azurerm_subnet_route_table_association" "rt_assoc" {
  for_each       = azurerm_subnet.subnets
  subnet_id      = each.value.id
  route_table_id = azurerm_route_table.spoke.id
}
