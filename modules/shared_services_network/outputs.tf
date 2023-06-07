output "virtual_network" {
  value = azurerm_virtual_network.main
}

output "citrix_cloud_connector" {
  value = azurerm_application_security_group.cloud_connector
}

output "fas" {
  value = azurerm_application_security_group.fas
}