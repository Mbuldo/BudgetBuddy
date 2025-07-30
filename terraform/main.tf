resource "azurerm_resource_group" "rg" {
  name     = "${var.project_name}-rg"
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.project_name}acr"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_postgresql_flexible_server" "db" {
  name                   = "${var.project_name}-db"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  administrator_login    = "postgres"
  administrator_password = "password123"
  version                = "16"
  storage_mb             = 32768
  sku_name               = "B_Standard_B1ms"
}

resource "azurerm_container_group" "app" {
  name                = "${var.project_name}-app"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"

  container {
    name   = "budgetbuddy"
    image  = "${azurerm_container_registry.acr.login_server}/${var.project_name}:latest"
    cpu    = "0.5"
    memory = "1.0"
    ports {
      port     = 5000
      protocol = "TCP"
    }

    environment_variables = {
      DATABASE_URL = "postgresql://postgres:password123@${azurerm_postgresql_flexible_server.db.fqdn}:5432/budgetbuddy"
    }
  }

  ip_address_type = "Public"
  dns_name_label  = "${var.project_name}-demo"
}
