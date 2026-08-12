output "vnet_id" {
  description = "The ID of the Spoke Virtual Network."
  value       = azurerm_virtual_network.spoke.id
}

output "vnet_name" {
  description = "The name of the Spoke Virtual Network."
  value       = azurerm_virtual_network.spoke.name
}

output "resource_group_name" {
  description = "The Resource Group name containing the Spoke Virtual Network."
  value       = azurerm_resource_group.spoke.name
}

output "subnet_ids" {
  description = "Map of subnet names to their respective subnet resource IDs in the Spoke VNet."
  value       = { for k, s in azurerm_subnet.subnets : k => s.id }
}
