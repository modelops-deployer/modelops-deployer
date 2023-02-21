resource "local_file" "ansible" {
  content = templatefile("../ansible/inventory.cfg.tpl", {
     user = var.user
     ip = azurerm_public_ip.mlopsip.ip_address
     pkey = abspath(local.pkey)
  }
)
  filename = "${path.module}/../ansible/inventory.cfg"
  file_permission = "0644"
}
