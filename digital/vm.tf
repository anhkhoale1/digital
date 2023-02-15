# Déployer votre subnet sur le resource group 7 de votre bloc count
# Déployer une machine virtuelle (Linux ou Windows Server sur votre subnet)
# Connectez vous à votre VM 

# Vous aurez besoin de : 
# Virtual Network 
# Subnet 
# Network Interface Card 
# Virtual Machine 
# IP Public 


resource "azurerm_public_ip" "ip" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = azurerm_resource_group.allrg[7].name
  location            = azurerm_resource_group.allrg[7].location
  allocation_method   = "Static"
}

resource "azurerm_virtual_network" "main" {
  name                = "raph-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.allrg[7].location
  resource_group_name = azurerm_resource_group.allrg[7].name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.allrg[7].name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "main" {
  name                = "raph-nic"
  location            = azurerm_resource_group.allrg[7].location
  resource_group_name = azurerm_resource_group.allrg[7].name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ip.id
  }
}

resource "azurerm_windows_virtual_machine" "raphvm" {
  name                = "raph-machine"
  resource_group_name = azurerm_resource_group.allrg[7].name
  location            = azurerm_resource_group.allrg[7].location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

Déployer un Log Analytics et récupérer les Metrics de votre Keyvault avec 
Diagnostic Settings 