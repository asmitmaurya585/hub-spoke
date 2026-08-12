resource "azurerm_resource_group" "asmit1" {
  for_each = var.asmitrg

  name     = each.value.name
  location = each.value.location
  tags     = try(each.value.tags, {})
}
