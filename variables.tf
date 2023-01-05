# Virtual machine settings
variable "vm_name" {
  type    = string
  default = "my-vm"
}

variable "vm_size" {
  type    = string
  default = "Standard_DS1_v2"
}

variable "vm_image" {
  type    = string
  default = "Canonical:UbuntuServer:18.04-LTS:latest"
}

# Resource group settings
variable "resource_group_name" {
  type    = string
  default = "my-resource-group"
}

variable "resource_group_location" {
  type    = string
  default = "westus"
}

# Virtual network settings
variable "vnet_name" {
  type    = string
  default = "my-vnet"
}

variable "vnet_address_space" {
  type    = list
  default = ["10.0.0.0/16"]
}

# Subnet settings
variable "subnet_name" {
  type    = string
  default = "my-subnet"
}

variable "subnet_address_prefix" {
  type    = string
  default = "10.0.1.0/24"
}

# Public IP address settings
variable "public_ip_name" {
  type    = string
  default = "my-ip"
}

variable "public_ip_allocation_method" {
  type    = string
  default = "Dynamic"
}

# Network security group settings
variable "nsg_name" {
  type    = string
  default = "my-nsg"
}

# Network security rule settings
variable "nsg_rule_name" {
  type    = string
  default = "my-rule"
}

variable "nsg_rule_priority" {
  type    = number
  default = 100
}

variable "nsg_rule_direction" {
  type    = string
  default = "Inbound"
}

variable "nsg_rule_access" {
  type    = string
  default = "Allow"
}

variable "nsg_rule_protocol" {
  type    = string
  default = "Tcp"
}

variable "nsg_rule_source_port_range" {
  type    = string
  default = "*"
}

variable "nsg_rule_destination_port_range" {
  type    = string
  default = "22"
}

variable "nsg_rule_source_address_prefix" {
  type    = string
  default = "*"
}

variable "nsg_rule_destination_address_prefix" {
  type    = string
  default = "*"
}
