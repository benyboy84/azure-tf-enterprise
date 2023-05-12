# The following block of locals are used to avoid using empty object types in the code
locals {
  empty_list   = []
  empty_map    = tomap({})
  empty_string = ""
}

# The following locals are used to convert provided input variables to locals before use elsewhere in the module
locals {
  root_id              = var.root_id
  root_name            = var.root_name
  root_parent_id       = var.root_parent_id
  custom_landing_zones = var.custom_landing_zones
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
