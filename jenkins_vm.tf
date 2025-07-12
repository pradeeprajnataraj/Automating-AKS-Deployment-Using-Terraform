# ------------------------------------------------------
# All Jenkins-related infrastructure has been moved to aks.tf
# This file is now commented out to prevent duplication errors.
# ------------------------------------------------------

# resource "azurerm_public_ip" "jenkins_ip" {
#   name                = "jenkins-public-ip"
#   location            = "eastus"
#   resource_group_name = "aksrginfra"
#   allocation_method   = "Static"
#   sku                 = "Standard"
#
#   timeouts {
#     create = "10m"
#     update = "10m"
#   }
# }

# resource "azurerm_network_interface" "jenkins_nic" {
#   name                = "jenkins-nic"
#   location            = "eastus"
#   resource_group_name = "aksrginfra"
#
#   ip_configuration {
#     name                          = "jenkins-ipconfig"
#     subnet_id                     = azurerm_subnet.aks_subnet.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.jenkins_ip.id
#   }
# }

# resource "azurerm_network_security_group" "jenkins_nsg" {
#   name                = "jenkins-nsg"
#   location            = "eastus"
#   resource_group_name = "aksrginfra"
#
#   security_rule {
#     name                       = "SSH"
#     priority                   = 1001
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "22"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
#
#   security_rule {
#     name                       = "Jenkins"
#     priority                   = 1002
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "8080"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
# }

# resource "azurerm_network_interface_security_group_association" "jenkins_nic_nsg" {
#   network_interface_id      = azurerm_network_interface.jenkins_nic.id
#   network_security_group_id = azurerm_network_security_group.jenkins_nsg.id
# }
