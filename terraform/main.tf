resource "azurerm_resource_group" "rg" {
  name     = "budgetbuddy-rg"
  location = "eastus"
}

resource "azurerm_container_registry" "acr" {
  name                = "budgetbuddyacr"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_storage_account" "storage" {
  name                     = "budgetbuddystorage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "sqlite" {
  name                 = "sqlite-data"
  storage_account_id = azurerm_storage_account.storage.id
  quota                = 1  # 1GB
}

resource "azurerm_container_group" "app" {
  name                = "budgetbuddy-app"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  ip_address_type     = "Public"
  os_type             = "Linux"
  dns_name_label      = "budgetbuddy-demo"

  container {
    name   = "budgetbuddy"
    image  = "${azurerm_container_registry.acr.login_server}/budgetbuddy:latest"
    cpu    = "0.5"
    memory = "1"

    ports {
      port     = 5000
      protocol = "TCP"
    }

    volume {
      name       = "sqlite-data"
      mount_path = "/app/data"
      read_only  = false
      storage_account_name = azurerm_storage_account.storage.name
      storage_account_key  = azurerm_storage_account.storage.primary_access_key
      share_name          = azurerm_storage_share.sqlite.name
    }
  }
  image_registry_credential {
    server   = azurerm_container_registry.acr.login_server
    username = azurerm_container_registry.acr.admin_username
    password = azurerm_container_registry.acr.admin_password
  }
}