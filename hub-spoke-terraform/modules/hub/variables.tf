variable "resource_group_name" {
  description = "Name of the Resource Group for the Hub network."
  type        = string
}

variable "location" {
  description = "Azure region for the Hub infrastructure."
  type        = string
}

variable "vnet_name" {
  description = "Name of the Hub Virtual Network."
  type        = string
  default     = "vnet-hub"
}

variable "address_space" {
  description = "Address space CIDR blocks for the Hub VNet."
  type        = list(string)
}

variable "subnets" {
  description = "Map of subnet configurations where key is subnet name and value is list of address prefixes."
  type        = map(list(string))
}

variable "tags" {
  description = "Tags to be assigned to Hub resources."
  type        = map(string)
  default     = {}
}
