output "hub_vnet_id" {
  description = "The Resource ID of the central Hub Virtual Network."
  value       = module.hub.vnet_id
}

output "hub_subnet_ids" {
  description = "Map of Hub subnet names to their Azure Resource IDs."
  value       = module.hub.subnet_ids
}

output "spoke_vnet_ids" {
  description = "Map of spoke names to their Virtual Network Resource IDs."
  value       = { for k, v in module.spokes : k => v.vnet_id }
}

output "spoke_subnet_ids" {
  description = "Map of spoke names to maps of their subnet names and Resource IDs."
  value       = { for k, v in module.spokes : k => v.subnet_ids }
}

output "peering_ids" {
  description = "Map of spoke names to their Hub-to-Spoke and Spoke-to-Hub peering Resource IDs."
  value = {
    for k, v in module.peerings : k => {
      hub_to_spoke = v.hub_to_spoke_peering_id
      spoke_to_hub = v.spoke_to_hub_peering_id
    }
  }
}
