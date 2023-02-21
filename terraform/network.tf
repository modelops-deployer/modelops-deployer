# Create a virtual network
resource "azurerm_virtual_network" "mlopsvnet" {
  name                = "mlops-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.mlopsrg.name
}

# Create a subnet
resource "azurerm_subnet" "mlopssubnet" {
  name                 = "mlops-subnet"
  resource_group_name  = azurerm_resource_group.mlopsrg.name
  virtual_network_name = azurerm_virtual_network.mlopsvnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a public IP address
resource "azurerm_public_ip" "mlopsip" {
  name                = "mlops-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.mlopsrg.name
  allocation_method   = "Static"
}


# Create a network interface
resource "azurerm_network_interface" "mlopsnic" {
  name                      = "mlops-nic"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.mlopsrg.name

  ip_configuration {
    name                          = "mlops-config"
    subnet_id                     = azurerm_subnet.mlopssubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mlopsip.id
  }
}


# Create firewall rules
resource "azurerm_network_security_group" "mlopsnsg" {
  name                = "mlops-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.mlopsrg.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTPS"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_subnet_network_security_group_association" "nsgsn" {
  subnet_id                 = azurerm_subnet.mlopssubnet.id
  network_security_group_id = azurerm_network_security_group.mlopsnsg.id
}
