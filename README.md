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

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.3.1)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 3.54.0)

## Modules

No modules.

<!-- markdownlint-disable MD013 -->
<!-- markdownlint-disable MD034 -->
## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_custom_landing_zones"></a> [custom\_landing\_zones](#input\_custom\_landing\_zones)

Description: If specified, will deploy additional Management Groups alongside Enterprise-scale core Management Groups.  
Although the object type for this input variable is set to `any`, the expected object is based on the following structure:
```terraform
variable "custom_landing_zones" {
  type = map(
    object({
      display_name               = string
      parent_management_group_id = string
      subscription_ids           = list(string)
      archetype_config = object({
        archetype_id   = string
        parameters     = map(any)
        access_control = map(list(string))
      })
    })
  )
```  
The decision not to hard code the structure in the input variable `type` is by design, as it allows Terraform to handle the input as a dynamic object type.  
This was necessary to allow the `parameters` value to be correctly interpreted.  
Without this, Terraform would throw an error if each parameter value wasn't a consistent type, as it would incorrectly identify the input as a `tuple` which must contain consistent type structure across all entries.  
The `custom_landing_zones` object is used to deploy additional Management Groups within the core Management Group hierarchy.  
The main object parameters are `display_name`, `parent_management_group_id`, `subscription_ids`and `archetype_config`.
- `display_name` is the name assigned to the Management Group.
- `parent_management_group_id` is the name of the parent Management Group and must be a valid Management Group ID.
- `subscription_ids` is an object containing a list of Subscription IDs to assign to the current Management Group.
- `archetype_config` is used to configure the configuration applied to each Management Group. This object must contain valid entries for the `archetype_id` `parameters`, and `access_control` attributes.  
The following example shows how you would add a simple Management Group under the `myorg-landing-zones` Management Group, where `root_id = "myorg"` and using the default\_empty archetype definition.
```terraform
  custom_landing_zones = {
    myorg-customer-corp = {
      display_name               = "MyOrg Customer Corp"
      parent_management_group_id = "myorg-landing-zones"
      subscription_ids           = [
        "00000000-0000-0000-0000-000000000000",
        "11111111-1111-1111-1111-111111111111",
      ]
      archetype_config = {
        archetype_id   = "default_empty"
        parameters     = {}
        access_control = {}
      }
    }
  }
```

Type: `any`

Default: `{}`

## Resources

The following resources are used by this module:

- [azurerm_management_group.level_1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) (resource)
- [azurerm_management_group.level_2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) (resource)
- [azurerm_management_group.level_3](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) (resource)
- [azurerm_management_group.level_4](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) (resource)
- [azurerm_management_group.level_5](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) (resource)
- [azurerm_management_group.level_6](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) (resource)

## Outputs

The following outputs are exported:

### <a name="output_azurerm_management_group"></a> [azurerm\_management\_group](#output\_azurerm\_management\_group)

Description: Returns the configuration data for all Management Groups created by this module.

<!-- markdownlint-enable -->

<!-- END_TF_DOCS -->