terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.61.0"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "core" {}

module "azure_landing_zones" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "~> 4.0.2"

  default_location  = var.default_location
  disable_telemetry = true

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm
    azurerm.management   = azurerm
  }

  root_parent_id = data.azurerm_client_config.core.tenant_id
  root_id        = var.root_id
  root_name      = var.root_name
  library_path   = "${path.root}/lib"

  archetype_config_overrides = {
    landing-zones = {
      archetype_id = "es_landing_zones"
      parameters = {
        Deny-Subnet-Without-Nsg = {
          effect = "Audit"
        }
        Deploy-VM-Backup = {
          effect = "AuditIfNotExists"
        }
      }
      access_control = {}
    }
  }

  subscription_id_overrides = {
    sandboxes = var.sandbox_subscriptions
  }

  custom_landing_zones = {
    "${var.root_id}-citrix" = {
      display_name               = "Citrix"
      parent_management_group_id = "${var.root_id}-landing-zones"
      subscription_ids           = []
      archetype_config = {
        archetype_id = "citrix"
        parameters = {
          Deny-Resource-Locations = {
            listOfAllowedLocations = [
              "norwayeast",
              "norwaywest",
              "westeurope"
            ]
          }
          Deny-RSG-Locations = {
            listOfAllowedLocations = [
              "norwayeast",
              "norwaywest",
              "westeurope"
            ]
          }
        }
        access_control = {}
      }
    }
    "${var.root_id}-analytics" = {
        display_name               = "Analytics"
        parent_management_group_id = "${var.root_id}-landing-zones"
        subscription_ids           = []
        archetype_config = {
          archetype_id = "analytics"
          parameters = {
            Deny-Resource-Locations = {
              listOfAllowedLocations = [
                "norwayeast",
                "norwaywest",
                "westeurope"
              ]
            }
            Deny-RSG-Locations = {
              listOfAllowedLocations = [
                "norwayeast",
                "norwaywest",
                "westeurope"
              ]
            }
          }
          access_control = {}
        }
      }
  }
}


resource "azurerm_resource_group" "shared_services" {
  name     = "rg-ci-shared-services"
  location = var.default_location
}

module "shared_services_network" {
  source = "./modules/shared_services_network"
  resource_group = azurerm_resource_group.shared_services
  vnet_address_space = ["10.42.0.0/23"]
}