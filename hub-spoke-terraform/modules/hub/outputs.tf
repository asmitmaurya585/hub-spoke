output "vnet_id" {
  description = "The ID of the Hub Virtual Network."
  value       = azurerm_virtual_network.hub.id
}

output "vnet_name" {
  description = "The name of the Hub Virtual Network."
  value       = azurerm_virtual_network.hub.name
}

output "resource_group_name" {
  description = "The Resource Group name containing the Hub Virtual Network."
  value       = azurerm_resource_group.hub.name
}

output "subnet_ids" {
  description = "Map of subnet names to their respective subnet resource IDs in the Hub VNet."
  value       = { for k, s in azurerm_subnet.subnets : k => s.id }
}
