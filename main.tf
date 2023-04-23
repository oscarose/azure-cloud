resource "azurerm_resource_group" "rg" {
  name     = "myTFResourceGroup"
  location = "centralus"
}

resource "azurerm_virtual_network" "postgres_flexible_server_virtual_network" {
  name                = var.virtual_network_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "postgres_flexible_server_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.postgres_flexible_server_virtual_network.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}
resource "azurerm_private_dns_zone" "oscarosedns" {
  name                = "oscarosedns.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "oscarosednszone" {
  name                  = "oscarosednszoneVnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.oscarosedns.name
  virtual_network_id    = azurerm_virtual_network.postgres_flexible_server_virtual_network.id
  resource_group_name   = azurerm_resource_group.rg.name
}

resource "azurerm_postgresql_flexible_server" "postgres_flexible" {
  name                   = local.server_name
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  version                = var.pfsql_vid
  delegated_subnet_id    = azurerm_subnet.postgres_flexible_server_subnet.id
  private_dns_zone_id    = azurerm_private_dns_zone.oscarosedns.id
  administrator_login    = var.db_user
  administrator_password = var.db_password
  zone                   = var.zone_number
  storage_mb             = var.storage_mb
  sku_name               = var.sku_name
  depends_on             = [azurerm_private_dns_zone_virtual_network_link.oscarosednszone]
  tags                   = local.tags
}

resource "azuread_group" "postgres_flexible_server_ad_group" {
  display_name            = "sg-jit-${local.server_name}"
  owners                  = [data.azuread_client_config.current.object_id]
  prevent_duplicate_names = true
  security_enabled        = true
}

