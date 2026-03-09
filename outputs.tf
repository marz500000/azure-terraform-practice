output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.practice.name
}

output "resource_group_id" {
  description = "Full Azure resource ID of the resource group"
  value       = azurerm_resource_group.practice.id
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.practice.name
}

output "vnet_id" {
  description = "Full Azure resource ID of the VNet"
  value       = azurerm_virtual_network.practice.id
}

output "subnet_name" {
  description = "Name of the subnet"
  value       = azurerm_subnet.practice.name
}

output "subnet_id" {
  description = "Full Azure resource ID of the subnet"
  value       = azurerm_subnet.practice.id
}
output "nsg_id" {
  description = "Full Azure resource ID of the NSG"
  value       = azurerm_network_security_group.practice.id
}

output "nsg_name" {
  description = "Name of the NSG"
  value       = azurerm_network_security_group.practice.name
}