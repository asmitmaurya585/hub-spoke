output "resource_groups" {
  description = "Map of created resource group objects."
  value       = azurerm_resource_group.asmit1
}

output "resource_group_names" {
  description = "Map of created resource group names."
  value       = { for k, v in azurerm_resource_group.asmit1 : k => v.name }
}
