resource "azurerm_lb" "mlopslb" {
  name                = "modelops"
  location            = var.location
  resource_group_name = azurerm_resource_group.mlopsrg.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.mlopsip.id

  }
}
