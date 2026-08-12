variable "spoke_key" {
  description = "Unique identifier / key for the spoke environment (e.g. dev, prod)."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group for the Spoke network."
  type        = string
}

variable "location" {
  description = "Azure region for the Spoke infrastructure."
  type        = string
}

variable "vnet_name" {
  description = "Name of the Spoke Virtual Network."
  type        = string
}

variable "address_space" {
  description = "Address space CIDR blocks for the Spoke VNet."
  type        = list(string)
}

variable "subnets" {
  description = "Map of subnet configurations where key is subnet name and value is list of address prefixes."
  type        = map(list(string))
}

variable "tags" {
  description = "Tags to be assigned to Spoke resources."
  type        = map(string)
  default     = {}
}
