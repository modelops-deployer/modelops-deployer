resource "azurerm_managed_disk" "disk120" {
  name                 = "${var.vmname}-disk120"
  location             = azurerm_resource_group.mlopsrg.location
  resource_group_name  = azurerm_resource_group.mlopsrg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.disksize
  lifecycle {
    	prevent_destroy = true
 }
}

resource "azurerm_virtual_machine_data_disk_attachment" "vmdisk" {
  managed_disk_id    = azurerm_managed_disk.disk120.id
  virtual_machine_id = azurerm_virtual_machine.mlops.id
  lun                = "10"
  caching            = "ReadWrite"
}
