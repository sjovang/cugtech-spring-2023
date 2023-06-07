resource "azurerm_virtual_network" "main" {
  name                = "vnet-citrix-shared-services"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "main" {
  name                 = "sn-shared-services"
  resource_group_name  = var.resource_group.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [cidrsubnet(var.vnet_address_space[0], 3, 0)]
}

resource "azurerm_network_security_group" "main" {
  name                = "nsg-shared-services"
  resource_group_name = var.resource_group.name
  location = var.resource_group.location
}

resource "azurerm_subnet_network_security_group_association" "main" {
  subnet_id                 = azurerm_subnet.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_network_security_rule" "in_deny_all" {
  name                        = "in_deny_all"
  priority                    = 4096
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group.name
  network_security_group_name = azurerm_network_security_group.main.name
}

resource "azurerm_application_security_group" "fas" {
  name                = "asg-citrix-federated-authentication-service"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
}

resource "azurerm_network_security_rule" "in_allow_fas" {
  name              = "in_allow_fas"
  priority          = 100
  direction         = "Inbound"
  access            = "Allow"
  protocol          = "Tcp"
  source_port_range = "*"
  destination_port_ranges = [
    80,
    443
  ]
  source_address_prefix = "VirtualNetwork"
  destination_application_security_group_ids = [
    azurerm_application_security_group.fas.id
  ]
  resource_group_name = var.resource_group.name
  network_security_group_name = azurerm_network_security_group.main.name
}

resource "azurerm_application_security_group" "cloud_connector" {
  name                = "asg-citrix-cloud-connector"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
}

resource "azurerm_network_security_rule" "in_allow_cloud_connector" {
  name              = "in_allow_cc"
  priority          = 200
  direction         = "Inbound"
  access            = "Allow"
  protocol          = "Tcp"
  source_port_range = "*"
  destination_port_ranges = [
    80,
    443
  ]
  source_address_prefix = "VirtualNetwork"
  destination_application_security_group_ids = [
    azurerm_application_security_group.cloud_connector.id
  ]
  resource_group_name = var.resource_group.name
  network_security_group_name = azurerm_network_security_group.main.name
}