resource "azurerm_virtual_machine" "mlops" {
  name                  = "modelops"
  location              = var.location
  resource_group_name   = azurerm_resource_group.mlopsrg.name
  network_interface_ids = [azurerm_network_interface.mlopsnic.id]
  vm_size               = var.vmsize

  delete_os_disk_on_termination = true
  storage_os_disk {
    name              = "mlops-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
#    disk_size_gb = 120
#    managed_disk_type = "Premium_LRS"
  }

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_5-gen2"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.vmname
    admin_username = var.user
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = tls_private_key.pkey.public_key_openssh
      path = "/home/${var.user}/.ssh/authorized_keys"
    }
  }
}
