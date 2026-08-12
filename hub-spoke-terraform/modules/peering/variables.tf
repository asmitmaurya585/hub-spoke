variable "peering_name_hub_to_spoke" {
  description = "Name of the peering from Hub to Spoke VNet."
  type        = string
}

variable "peering_name_spoke_to_hub" {
  description = "Name of the peering from Spoke to Hub VNet."
  type        = string
}

variable "hub_resource_group_name" {
  description = "Resource Group name where the Hub VNet is deployed."
  type        = string
}

variable "hub_vnet_name" {
  description = "Name of the Hub Virtual Network."
  type        = string
}

variable "hub_vnet_id" {
  description = "Resource ID of the Hub Virtual Network."
  type        = string
}

variable "spoke_resource_group_name" {
  description = "Resource Group name where the Spoke VNet is deployed."
  type        = string
}

variable "spoke_vnet_name" {
  description = "Name of the Spoke Virtual Network."
  type        = string
}

variable "spoke_vnet_id" {
  description = "Resource ID of the Spoke Virtual Network."
  type        = string
}

variable "allow_virtual_network_access" {
  description = "Controls if VMs in the remote VNet can access VMs in the local VNet."
  type        = bool
  default     = true
}

variable "allow_forwarded_traffic" {
  description = "Controls if forwarded traffic from VMs in the remote VNet is allowed."
  type        = bool
  default     = true
}

variable "allow_gateway_transit" {
  description = "Controls if gateway transit is allowed on the Hub to Spoke peering."
  type        = bool
  default     = false
}

variable "use_remote_gateways" {
  description = "Controls if the Spoke VNet uses remote gateways in the Hub VNet."
  type        = bool
  default     = false
}
