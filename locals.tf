# The following block of locals are used to customize the Azure Enterprise Landing Zone.
locals {
  # The root_parent_id is used to specify where to set the root for all Landing Zone deployments. Usually the Tenant ID when deploying the core Enterprise-scale Landing Zones.
  root_parent_id = "0f9829d3-a628-4f2b-a3ac-58e0740d27ae"

  # Will set a custom Name (ID) value for the Enterprise-scale \"root\" Management Group, and append this to the ID for all core Enterprise-scale Management Groups."
  root_id = "mg"

  # Will set a custom Display Name value for the Enterprise-scale \"root\" Management Group.
  root_name = "Conseils TI"

  # Mandatory core Enterprise-scale Management Groups
  es_core_landing_zones = {
    (local.root_id) = {
      display_name               = local.root_name
      parent_management_group_id = local.root_parent_id
      # subscription_name        = name
    }
    "${local.root_id}-decommissioned" = {
      display_name               = "Decommissioned"
      parent_management_group_id = local.root_id
      # subscription_name        = name
    }
    "${local.root_id}-sandboxes" = {
      display_name               = "Sandboxes"
      parent_management_group_id = local.root_id
      # subscription_name        = name
    }
    "${local.root_id}-landing-zones" = {
      display_name               = "Landing Zones"
      parent_management_group_id = local.root_id
      # subscription_name        = name
    }
    "${local.root_id}-corp" = {
      display_name               = "Corp"
      parent_management_group_id = "${local.root_id}-landing-zones"
      # subscription_name        = name
    },
    "${local.root_id}-online" = {
      display_name               = "Online"
      parent_management_group_id = "${local.root_id}-landing-zones"
      # subscription_name        = name
    },
    "${local.root_id}-pci" = {
      display_name               = "PCI"
      parent_management_group_id = "${local.root_id}-landing-zones"
      # subscription_name        = name
    },
    "${local.root_id}-platform" = {
      display_name               = "Platform"
      parent_management_group_id = "${local.root_id}-landing-zones"
      # subscription_name        = name
    }
    "${local.root_id}-connectivity" = {
      display_name               = "Connectivity"
      parent_management_group_id = "${local.root_id}-platform"
      # subscription_name        = name
    }
    "${local.root_id}-management" = {
      display_name               = "Management"
      parent_management_group_id = "${local.root_id}-platform"
      # subscription_name        = name
    }
    "${local.root_id}-identity" = {
      display_name               = "Identity"
      parent_management_group_id = "${local.root_id}-platform"
      # subscription_name        = name
    }
  }
}

# The following block of locals are used to avoid using empty object types in the code
locals {
  empty_string = ""
}

# The following locals are used to define base Azure
# provider paths and resource types
locals {
  provider_path = {
    management_groups = "/providers/Microsoft.Management/managementGroups/"
    role_assignment   = "/providers/Microsoft.Authorization/roleAssignments/"
  }
}
