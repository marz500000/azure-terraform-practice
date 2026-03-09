variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "eastus"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "test"
}

variable "owner" {
  description = "Owner of the resources"
  type        = string
  default     = "Markus"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-terraform-practice"
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "vnet-terraform-practice"
}

variable "vnet_address_space" {
  description = "Address space for the VNet"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "snet-terraform-practice"
}

variable "subnet_prefix" {
  description = "Address prefix for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}
variable "nsg_name" {
  description = "Name of the network security group"
  type        = string
  default     = "nsg-terraform-practice"
}
