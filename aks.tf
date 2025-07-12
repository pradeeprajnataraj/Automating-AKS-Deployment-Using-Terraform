# -----------------------------
# Virtual Network & Subnet
# -----------------------------
resource "azurerm_virtual_network" "aks_vnet" {
  name                = "aks-vnet"
  location            = "eastus"
  resource_group_name = "aksrginfra"
  address_space       = ["10.0.0.0/16"]

  timeouts {
    create = "10m"
    update = "10m"
  }
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "aks-subnet"
  resource_group_name  = "aksrginfra"
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  lifecycle {
    ignore_changes = [
      address_prefixes,
      delegation,
      service_endpoints
    ]
  }
}

# -----------------------------
# Jenkins Public IP
# -----------------------------
resource "azurerm_public_ip" "jenkins_ip" {
  name                = "jenkins-public-ip"
  location            = "eastus"
  resource_group_name = "aksrginfra"
  allocation_method   = "Static"
  sku                 = "Standard"

  timeouts {
    create = "10m"
    update = "10m"
  }
}

# -----------------------------
# Jenkins Network Interface
# -----------------------------
resource "azurerm_network_interface" "jenkins_nic" {
  name                = "jenkins-nic"
  location            = "eastus"
  resource_group_name = "aksrginfra"

  ip_configuration {
    name                          = "jenkins-ipconfig"
    subnet_id                     = azurerm_subnet.aks_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jenkins_ip.id
  }
}

# -----------------------------
# Jenkins NSG
# -----------------------------
resource "azurerm_network_security_group" "jenkins_nsg" {
  name                = "jenkins-nsg"
  location            = "eastus"
  resource_group_name = "aksrginfra"

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Jenkins"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# -----------------------------
# Associate NIC to NSG
# -----------------------------
resource "azurerm_network_interface_security_group_association" "jenkins_nic_nsg" {
  network_interface_id      = azurerm_network_interface.jenkins_nic.id
  network_security_group_id = azurerm_network_security_group.jenkins_nsg.id
}

# -----------------------------
# AKS Data Source (non-destructive)
# -----------------------------
# data "azurerm_kubernetes_cluster" "aks" {
# name                = "akscluster1100"
#  resource_group_name = "aksrginfra"
# }
