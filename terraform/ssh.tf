resource "tls_private_key" "pkey" {
  algorithm = "RSA"
  rsa_bits  = 4096 
}

resource "local_sensitive_file" "pkey" {
  content = tls_private_key.pkey.private_key_openssh
  filename = local.pkey
  file_permission = "0600"

}
