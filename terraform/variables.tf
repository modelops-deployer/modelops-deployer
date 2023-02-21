variable "location" {
   default = "westeurope"
}

variable "vmsize" {
   #default = "Standard_D8s_v5"
   #default = "Standard_B8ms"
   #default = "Standard_E4ds_v4"
   default = "Standard_E4_v5"
}

variable "vmname" {
   default = "modelops"
}

variable "disksize" {
  type = number
  default = 120
}

variable "user" {
  default = "modelops"
}

variable "dns" {
  default = "modelops"
}

locals {
  pkey = "${path.module}/pkey"
}

