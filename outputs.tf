output "db_password" {
  value     = var.db_password
  sensitive = true
}

output "db_user" {
  value = var.db_user
}

output "server_fqdn" {
  value = azurerm_postgresql_flexible_server.postgres_flexible.fqdn
}

output "server_name" {
  value = azurerm_postgresql_flexible_server.postgres_flexible.name
}

output "server_id" {
  value = azurerm_postgresql_flexible_server.postgres_flexible.id
}

output "ad_group_name" {
  value = azuread_group.postgres_flexible_server_ad_group.display_name
}

