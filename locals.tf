# The following block of locals are used to avoid using empty object types in the code
locals {
  empty_list   = []
  empty_map    = tomap({})
  empty_string = ""
}

# The following locals are used to convert provided input variables to locals before use elsewhere in the module
locals {
  root_id        = var.root_id
  root_name      = var.root_name
  root_parent_id = var.root_parent_id
}

# The following locals are used to define base Azure
# provider paths and resource types
locals {
  provider_path = {
    management_groups = "/providers/Microsoft.Management/managementGroups/"
    role_assignment   = "/providers/Microsoft.Authorization/roleAssignments/"
  }
  resource_types = {
    policy_definition     = "Microsoft.Authorization/policyDefinitions"
    policy_set_definition = "Microsoft.Authorization/policySetDefinitions"
  }
}

# The following locals are used to control time_sleep
# delays between resources to reduce transient errors
# relating to replication delays in Azure
locals {
  create_duration_delay = {
    after_azurerm_management_group      = var.create_duration_delay["azurerm_management_group"]
    after_azurerm_policy_assignment     = var.create_duration_delay["azurerm_policy_assignment"]
    after_azurerm_policy_definition     = var.create_duration_delay["azurerm_policy_definition"]
    after_azurerm_policy_set_definition = var.create_duration_delay["azurerm_policy_set_definition"]
    after_azurerm_role_assignment       = var.create_duration_delay["azurerm_role_assignment"]
    after_azurerm_role_definition       = var.create_duration_delay["azurerm_role_definition"]
  }
  destroy_duration_delay = {
    after_azurerm_management_group      = var.destroy_duration_delay["azurerm_management_group"]
    after_azurerm_policy_assignment     = var.destroy_duration_delay["azurerm_policy_assignment"]
    after_azurerm_policy_definition     = var.destroy_duration_delay["azurerm_policy_definition"]
    after_azurerm_policy_set_definition = var.destroy_duration_delay["azurerm_policy_set_definition"]
    after_azurerm_role_assignment       = var.destroy_duration_delay["azurerm_role_assignment"]
    after_azurerm_role_definition       = var.destroy_duration_delay["azurerm_role_definition"]
  }
}