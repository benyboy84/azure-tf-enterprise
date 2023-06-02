<!-- BEGIN_TF_DOCS -->
# Azure landing zones Terraform - Level 1

[![GitHub Super-Linter](https://github.com/benyboy84/azure-tf-enterprise/blob/ft_management_groups/.github/workflows/build/badge.svg)](https://github.com/marketplace/actions/super-linter)[![License](https://img.shields.io/github/license/terraform-docs/terraform-docs)](https://github.com/benyboy84/azure-tf-enterprise/blob/main/LICENSE)

## Overview

### Level 1: Core platform governance

* The **Azure landing zone** include the core ALZ (formerly called enterprise-scale) capabilities with the related custom management group structures, subscriptions, policies configuration...

![Levels Hierarchy - Cloud Adoption Framework for Terraform landing zones.](https://github.com/benyboy84/azure-tf-enterprise/blob/ft_management_groups/docs/media/Levels%20Hierarchy%20_%20Cloud%20Adoption%20Framework%20for%20Terraform%20landing%20zones.png)

This is currently split logically into the following capabilities (*links to further information on the Wiki*):

| Scope |
| :--- |
| [Management group and Subscriptions](https://github.com/benyboy84/azure-tf-enterprise/wiki/Management-Groups-&-Management-group-and-Subscriptions) |
| [Policies and Policies Assignments](https://github.com/benyboy84/azure-tf-enterprise/wiki) |

## prerequisite

* Service Principale with Owner role at the Root Level and billing account...

## Documentation

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.3.1)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 3.54.0)

## Modules

No modules.

## Required Inputs

No required inputs.

## Optional Inputs

No optional inputs.

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
## References

###### 1. [Define your naming convention](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming)
###### 2. [Management groups](https://learn.microsoft.com/en-us/azure/governance/management-groups/overview)
###### 3. [Cloud Adoption Framework - Levels Hierarchy](https://aztfmod.github.io/documentation/docs/fundamentals/lz-intro/)
###### 4. [Azure Provider: Authenticating using a Service Principal with a Client Secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret)
###### 5. []() SPN role assignment
<!-- END_TF_DOCS -->