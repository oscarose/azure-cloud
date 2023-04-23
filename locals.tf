locals {
  server_name = join("-", ["pfsql", var.environment, var.owner])
  tags = {
  "Name"          = var.environment
  "Region"        = azurerm_resource_group.rg.location
  "Customer_Name" = var.owner
  }
}

