resource "azurerm_resource_group" "mlopsrg" {
  name     = "mlopsrg"
  location = var.location
    lifecycle {
    	prevent_destroy = true
   }
}
