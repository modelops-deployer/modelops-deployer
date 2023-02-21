output "publicip" {
  value = azurerm_public_ip.mlopsip.ip_address
}

#output "pkey" {
#  value = tls_private_key.pkey
#  sensitive = true
#}

