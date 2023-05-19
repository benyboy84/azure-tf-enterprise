# azure-tf-enterprise
Management Groups, Policies, Subscription, Identity Service, Management Service...

<!-- BEGIN_TF_DOCS -->
# Azure landing zones Terraform

[![GitHub Super-Linter](https://github.com/<OWNER>/<REPOSITORY>/actions/workflows/<WORKFLOW_FILE_NAME>/badge.svg)](https://github.com/marketplace/actions/super-linter)

## Overview

This is currently split logically into the following capabilities (*links to further information on the Wiki*):

| Scope |
| :--- |
| Management group and subscription organization |
| Service Principale and Role based Access |
| Poliicies and Policies Assignments |

## Documentation

== Requirements

[cols="a,a",options="header,autowidth"]
|===
|Name |Version
|[[requirement_terraform]] <<requirement_terraform,terraform>> |>= 1.3.1
|[[requirement_azurerm]] <<requirement_azurerm,azurerm>> |~> 3.54.0
|===

== Modules

No modules.

== Inputs

[cols="a,a,a,a,a",options="header,autowidth"]
|===
|Name |Description |Type |Default |Required
|[[input_custom_landing_zones]] <<input_custom_landing_zones,custom_landing_zones>>
|If specified, will deploy additional Management Groups alongside Enterprise-scale core Management Groups.
Although the object type for this input variable is set to `any`, the expected object is based on the following structure:
[source]
----
terraform
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
----
The decision not to hard code the structure in the input variable `type` is by design, as it allows Terraform to handle the input as a dynamic object type.
This was necessary to allow the `parameters` value to be correctly interpreted.
Without this, Terraform would throw an error if each parameter value wasn't a consistent type, as it would incorrectly identify the input as a `tuple` which must contain consistent type structure across all entries.
The `custom_landing_zones` object is used to deploy additional Management Groups within the core Management Group hierarchy.
The main object parameters are `display_name`, `parent_management_group_id`, `subscription_ids`and `archetype_config`.
- `display_name` is the name assigned to the Management Group.
- `parent_management_group_id` is the name of the parent Management Group and must be a valid Management Group ID.
- `subscription_ids` is an object containing a list of Subscription IDs to assign to the current Management Group.
- `archetype_config` is used to configure the configuration applied to each Management Group. This object must contain valid entries for the `archetype_id` `parameters`, and `access_control` attributes.
The following example shows how you would add a simple Management Group under the `myorg-landing-zones` Management Group, where `root_id = "myorg"` and using the default_empty archetype definition.
[source]
----
terraform
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
----

|`any`
|`{}`
|no

|===

== Resources

[cols="a,a",options="header,autowidth"]
|===
|Name |Type
|https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group[azurerm_management_group.level_1] |resource
|https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group[azurerm_management_group.level_2] |resource
|https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group[azurerm_management_group.level_3] |resource
|https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group[azurerm_management_group.level_4] |resource
|https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group[azurerm_management_group.level_5] |resource
|https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group[azurerm_management_group.level_6] |resource
|===

== Outputs

[cols="a,a",options="header,autowidth"]
|===
|Name |Description
|[[output_azurerm_management_group]] <<output_azurerm_management_group,azurerm_management_group>> |Returns the configuration data for all Management Groups created by this module.
|===


<!-- END_TF_DOCS -->