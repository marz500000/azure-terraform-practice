terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "tfstate17441"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_azuread_auth     = true
    subscription_id      = "37801a5c-83b4-4058-b714-f35a3fda099f"
    tenant_id            = "1f28b9ea-531d-48e5-a7e8-30a4d6b02c18"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "practice" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = var.environment
    owner       = var.owner
    purpose     = "terraform-learning"
  }
  lifecycle {
    prevent_destroy = false
  }
}
resource "azurerm_virtual_network" "practice" {
  name                = var.vnet_name
  location            = azurerm_resource_group.practice.location
  resource_group_name = azurerm_resource_group.practice.name
  address_space       = [var.vnet_address_space]

  tags = {
    environment = var.environment
    owner       = var.owner
    purpose     = "terraform-learning"
  }
  lifecycle {
    prevent_destroy = false
  }
}

resource "azurerm_subnet" "practice" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.practice.name
  virtual_network_name = azurerm_virtual_network.practice.name
  address_prefixes     = [var.subnet_prefix]
  lifecycle {
    prevent_destroy = false
  }
}
resource "azurerm_network_security_group" "practice" {
  name                = var.nsg_name
  location            = azurerm_resource_group.practice.location
  resource_group_name = azurerm_resource_group.practice.name

  security_rule {
    name                       = "allow-ssh"
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
    name                       = "allow-http"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-https"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }



  security_rule {
    name                       = "deny-all-inbound"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.environment
    owner       = var.owner
    purpose     = "terraform-learning"
  }
  lifecycle {
    prevent_destroy = false
  }
}

resource "azurerm_subnet_network_security_group_association" "practice" {
  subnet_id                 = azurerm_subnet.practice.id
  network_security_group_id = azurerm_network_security_group.practice.id
  lifecycle {
    prevent_destroy = false
  }
}

