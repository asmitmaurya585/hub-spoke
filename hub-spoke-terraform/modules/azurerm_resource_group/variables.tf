variable "asmitrg" {
  description = "Map of Resource Groups with name and location attributes."
  type = map(object({
    name     = string
    location = string
    tags     = optional(map(string), {})
  }))
}
