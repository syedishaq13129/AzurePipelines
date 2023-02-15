resource "azurerm_private_endpoint" "privateep" {
  name                = var.priendpname
  location            = var.location
  resource_group_name = var.rgname
  subnet_id           = var.subnetid

  private_service_connection {
    name = var.serconnection
    private_connection_resource_id = var.paasid
    is_manual_connection = var.pritype
    subresource_names     = var.subresourcename
  }
}


# location            = azurerm_resource_group.demo-rg1.location
#   resource_group_name = azurerm_resource_group.demo-rg1.name
#   subnet_id           = azurerm_subnet.subnet.id
#   private_connection_resource_id = azurerm_storage_account.Storageacc1.id