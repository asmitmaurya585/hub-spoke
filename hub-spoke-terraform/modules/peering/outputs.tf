output "hub_to_spoke_peering_id" {
  description = "Resource ID of the Hub to Spoke VNet peering."
  value       = azurerm_virtual_network_peering.hub_to_spoke.id
}

output "spoke_to_hub_peering_id" {
  description = "Resource ID of the Spoke to Hub VNet peering."
  value       = azurerm_virtual_network_peering.spoke_to_hub.id
}

output "hub_to_spoke_peering_name" {
  description = "Name of the Hub to Spoke VNet peering."
  value       = azurerm_virtual_network_peering.hub_to_spoke.name
}

output "spoke_to_hub_peering_name" {
  description = "Name of the Spoke to Hub VNet peering."
  value       = azurerm_virtual_network_peering.spoke_to_hub.name
}
