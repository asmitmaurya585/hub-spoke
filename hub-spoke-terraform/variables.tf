variable "asmitrg" {
  description = "Map of Resource Groups to deploy."
  type = map(object({
    name     = string
    location = string
    tags     = optional(map(string), {})
  }))
  default = {}
}

variable "topology" {
  description = "Nested map defining the Hub and Spoke network topology."
  type = object({
    hub = object({
      name           = optional(string)
      resource_group = optional(string)
      location       = string
      address_space  = list(string)
      subnets        = map(list(string))
      tags           = optional(map(string), {})
    })
    spokes = map(object({
      name           = optional(string)
      resource_group = optional(string)
      location       = string
      address_space  = list(string)
      subnets        = map(list(string))
      tags           = optional(map(string), {})
    }))
  })
}

variable "tags" {
  description = "Global default tags applied to all deployed Azure resources."
  type        = map(string)
  default = {
    Environment  = "LandingZone"
    ManagedBy    = "Terraform"
    Architecture = "HubAndSpoke"
  }
}
