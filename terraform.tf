# Configure the Azure Provider
provider "azurerm" {
  version = "2.37.0"
  features {}
}

# Load variables from the variable file
variable "tenant_id" {}
variable "vm_name" {}
variable "vm_size" {}
variable "vm_image" {}

variable "resource_group_name" {}

# Create a resource group
resource "azurerm_resource_group" "my_group" {
  name     = "my-resource-group"
  location = "westus"
}

# Create a service principal
resource "azurerm_azuread_service_principal" "my_sp" {
  display_name = "My Service Principal"
}

# Assign the "Contributor" role to the service principal at the subscription level
resource "azurerm_role_assignment" "contributor_role" {
  scope                = var.tenant_id
  role_definition_name = "Contributor"
  principal_id         = azurerm_azuread_service_principal.my_sp.id
}

# Create a virtual network
resource "azurerm_virtual_network" "my_vnet" {
  name                = "my-vnet"
  resource_group_name = azurerm_resource_group.my_group.name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.my_group.location
}

# Create a subnet
resource "azurerm_subnet" "my_subnet" {
  name                 = "my-subnet"
  resource_group_name  = azurerm_resource_group.my_group.name
  virtual_network_name = azurerm_virtual_network.my_vnet.name
  address_prefix       = "10.0.1.0/24"
}


# Create a public IP address
resource "azurerm_public_ip" "my_ip" {
  name                = "my-ip"
  resource_group_name = azurerm_resource_group.my_group.name
  location            = azurerm_resource_group.my_group.location
  allocation_method   = "Dynamic"
}

# Create a network security group
resource "azurerm_network_security_group" "my_nsg" {
  name                = "my-nsg"
  resource_group_name = azurerm_resource_group.my_group.name
  location            = azurerm_resource_group.my_group.location
}


# Create a security rule
resource "azurerm_network_security_rule" "my_rule" {
  name                        = "my-rule"
  resource_group_name         = azurerm_resource_group.my_group.name
  network_security_group_name  = azurerm_network_security_group.my_nsg.name
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}

# Create a Key Vault
resource "azurerm_key_vault" "my_key_vault" {
  name                = "my-key-vault"
  location            = azurerm_resource_group.my_group.location
  resource_group_name = azurerm_resource_group.my_group.name
  tenant_id           = var.tenant_id
  sku_name            = "standard"
}

# Retrieve a key from the Key Vault
resource "azurerm_key_vault_secret" "my_key" {
  name         = "my-key"
  key_vault_id = azurerm_key_vault.my_key_vault.id
}


# Create a virtual machine
resource "azurerm_virtual_machine" "my_vm" {
  name                  = "my-vm"
  resource_group_name   = azurerm_resource_group.my_group.name
  location              = azurerm_resource_group.my_group.location
  size                  = "Standard_DS1_v2"
  network_interface_ids = [azurerm_network_interface.my_nic.id]
  vm_image_id           = "Canonical:UbuntuServer:18
