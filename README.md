# azure-tf-enterprise
Management Groups, Policies, Subscription, Identity Service, Management Service...

<!-- BEGIN_TF_DOCS -->
# Azure landing zones Terraform

[![GitHub Super-Linter](https://github.com/<OWNER>/<REPOSITORY>/actions/workflows/<WORKFLOW\_FILE\_NAME>/badge.svg)](https://github.com/marketplace/actions/super-linter)

## Overview

This is currently split logically into the following capabilities (*links to further information on the Wiki*):

| Scope |
| :--- |
| Management group and subscription organization |
| Service Principale and Role based Access |
| Poliicies and Policies Assignments |

## Documentation
<!-- markdownlint-disable MD033 -->

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.54.0 |

## Modules

No modules.

<!-- markdownlint-disable MD013 -->
<!-- markdownlint-disable MD034 -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_landing_zones"></a> [custom\_landing\_zones](#input\_custom\_landing\_zones) | If specified, will deploy additional Management Groups alongside Enterprise-scale core Management Groups.<br>Although the object type for this input variable is set to `any`, the expected object is based on the following structure:<pre>terraform<br>variable "custom_landing_zones" {<br>  type = map(<br>    object({<br>      display_name               = string<br>      parent_management_group_id = string<br>      subscription_ids           = list(string)<br>      archetype_config = object({<br>        archetype_id   = string<br>        parameters     = map(any)<br>        access_control = map(list(string))<br>      })<br>    })<br>  )</pre>The decision not to hard code the structure in the input variable `type` is by design, as it allows Terraform to handle the input as a dynamic object type.<br>This was necessary to allow the `parameters` value to be correctly interpreted.<br>Without this, Terraform would throw an error if each parameter value wasn't a consistent type, as it would incorrectly identify the input as a `tuple` which must contain consistent type structure across all entries.<br>The `custom_landing_zones` object is used to deploy additional Management Groups within the core Management Group hierarchy.<br>The main object parameters are `display_name`, `parent_management_group_id`, `subscription_ids`and `archetype_config`.<br>- `display_name` is the name assigned to the Management Group.<br>- `parent_management_group_id` is the name of the parent Management Group and must be a valid Management Group ID.<br>- `subscription_ids` is an object containing a list of Subscription IDs to assign to the current Management Group.<br>- `archetype_config` is used to configure the configuration applied to each Management Group. This object must contain valid entries for the `archetype_id` `parameters`, and `access_control` attributes.<br>The following example shows how you would add a simple Management Group under the `myorg-landing-zones` Management Group, where `root_id = "myorg"` and using the default\_empty archetype definition.<pre>terraform<br>  custom_landing_zones = {<br>    myorg-customer-corp = {<br>      display_name               = "MyOrg Customer Corp"<br>      parent_management_group_id = "myorg-landing-zones"<br>      subscription_ids           = [<br>        "00000000-0000-0000-0000-000000000000",<br>        "11111111-1111-1111-1111-111111111111",<br>      ]<br>      archetype_config = {<br>        archetype_id   = "default_empty"<br>        parameters     = {}<br>        access_control = {}<br>      }<br>    }<br>  }</pre> | `any` | `{}` | no |

## Resources

| Name | Type |
|------|------|
| [azurerm_management_group.level_1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.level_2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.level_3](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.level_4](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.level_5](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group.level_6](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_management_group"></a> [azurerm\_management\_group](#output\_azurerm\_management\_group) | Returns the configuration data for all Management Groups created by this module. |

<!-- markdownlint-enable -->

<!-- END_TF_DOCS -->