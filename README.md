# Cugtech Spring 2023 - Azure landing zones

Tiny Azure landing zones demo for [cugtech spring 2023](https://cugtech.no)

## Auto-generated Terraform documentation
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.61.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.61.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_azure_landing_zones"></a> [azure\_landing\_zones](#module\_azure\_landing\_zones) | Azure/caf-enterprise-scale/azurerm | ~> 4.0.2 |
| <a name="module_shared_services_network"></a> [shared\_services\_network](#module\_shared\_services\_network) | ./modules/shared_services_network | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.shared_services](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_client_config.core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_location"></a> [default\_location](#input\_default\_location) | n/a | `string` | `"westeurope"` | no |
| <a name="input_root_id"></a> [root\_id](#input\_root\_id) | n/a | `string` | `"myorg"` | no |
| <a name="input_root_name"></a> [root\_name](#input\_root\_name) | n/a | `string` | `"My Organization"` | no |
| <a name="input_sandbox_subscriptions"></a> [sandbox\_subscriptions](#input\_sandbox\_subscriptions) | n/a | `list(string)` | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->