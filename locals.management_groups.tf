# The following locals are used to define the core Enterprise-scale Management Groups deployed and uses
# logic to determine the full Management Group deployment hierarchy.
locals {

  # Mandatory core Enterprise-scale Management Groups
  es_core_landing_zones = {
    (local.root_id) = {
      display_name               = local.root_name
      parent_management_group_id = local.root_parent_id
      # subscription_ids           = local.es_subscription_ids_map[local.root_id]
      # archetype_config           = local.es_archetype_config_map[local.root_id]
    }
    "${local.root_id}-decommissioned" = {
      display_name               = "Decommissioned"
      parent_management_group_id = local.root_id
      # subscription_ids           = local.es_subscription_ids_map["${local.root_id}-decommissioned"]
      # archetype_config           = local.es_archetype_config_map["${local.root_id}-decommissioned"]
    }
    "${local.root_id}-sandboxes" = {
      display_name               = "Sandboxes"
      parent_management_group_id = local.root_id
      # subscription_ids           = local.es_subscription_ids_map["${local.root_id}-sandboxes"]
      # archetype_config           = local.es_archetype_config_map["${local.root_id}-sandboxes"]
    }
    "${local.root_id}-landing-zones" = {
      display_name               = "Landing Zones"
      parent_management_group_id = local.root_id
      # subscription_ids           = local.es_subscription_ids_map["${local.root_id}-landing-zones"]
      # archetype_config           = local.es_archetype_config_map["${local.root_id}-landing-zones"]
    }
    "${local.root_id}-platform" = {
      display_name               = "Platform"
      parent_management_group_id = local.root_id
      # subscription_ids           = local.es_subscription_ids_map["${local.root_id}-platform"]
      # archetype_config           = local.es_archetype_config_map["${local.root_id}-platform"]
    }
    "${local.root_id}-connectivity" = {
      display_name               = "Connectivity"
      parent_management_group_id = "${local.root_id}-platform"
      # subscription_ids           = local.subscription_ids_connectivity
      # archetype_config           = local.es_archetype_config_map["${local.root_id}-connectivity"]
    }
    "${local.root_id}-management" = {
      display_name               = "Management"
      parent_management_group_id = "${local.root_id}-platform"
      # subscription_ids           = local.subscription_ids_management
      # archetype_config           = local.es_archetype_config_map["${local.root_id}-management"]
    }
    "${local.root_id}-identity" = {
      display_name               = "Identity"
      parent_management_group_id = "${local.root_id}-platform"
      # subscription_ids           = local.subscription_ids_identity
      # archetype_config           = local.es_archetype_config_map["${local.root_id}-identity"]
    }
  }

  # Local map containing all Management Groups to deploy
  es_landing_zones_merge = merge(
    local.local.es_core_landing_zones,
    # local.custom_landing_zones,
  )

  # Logic to auto-generate values for Management Groups if needed.
  # Allows the user to specify the Management Group ID when working with existing
  # Management Groups, or uses standard naming pattern if set to null.
  es_landing_zones_map = {
    for key, value in local.es_landing_zones_merge :
    "${local.provider_path.management_groups}${key}" => {
      id                         = key
      display_name               = value.display_name
      parent_management_group_id = coalesce(value.parent_management_group_id, local.root_parent_id)
      # subscription_ids           = value.subscription_ids
      # subscription_ids           = local.strict_subscription_association ? value.subscription_ids : null
      #   archetype_config = {
      #     archetype_id   = value.archetype_config.archetype_id
      #     access_control = value.archetype_config.access_control
      #     parameters = {
      #       # The following logic merges parameter values from the connectivity,
      #       # identity and management sub-modules with the archetype defaults
      #       # (including custom_landing_zones) and archetype_config_overrides.
      #       # These values are then passed to the parameters input variable of the
      #       # archetypes sub-module.
      #       for policy_name in toset(keys(merge(
      #         lookup(module.connectivity_resources.configuration.archetype_config_overrides, key, local.parameter_map_default).parameters,
      #         lookup(module.identity_resources.configuration.archetype_config_overrides, key, local.parameter_map_default).parameters,
      #         lookup(module.management_resources.configuration.archetype_config_overrides, key, local.parameter_map_default).parameters,
      #         value.archetype_config.parameters,
      #       ))) :
      #       policy_name => merge(
      #         lookup(lookup(module.connectivity_resources.configuration.archetype_config_overrides, key, local.parameter_map_default).parameters, policy_name, null),
      #         lookup(lookup(module.identity_resources.configuration.archetype_config_overrides, key, local.parameter_map_default).parameters, policy_name, null),
      #         lookup(lookup(module.management_resources.configuration.archetype_config_overrides, key, local.parameter_map_default).parameters, policy_name, null),
      #         lookup(value.archetype_config.parameters, policy_name, null),
      #       )
      #     }
      #   }
    }
  }

}

# The following locals are used to build the map of Management Groups to deploy at each level of the hierarchy.
locals {
  azurerm_management_group_level_1 = {
    for key, value in local.es_landing_zones_map :
    key => value
    if value.parent_management_group_id == local.root_parent_id
  }
  azurerm_management_group_level_2 = {
    for key, value in local.es_landing_zones_map :
    key => value
    if contains(keys(azurerm_management_group.level_1), try(length(value.parent_management_group_id) > 0, false) ? "${local.provider_path.management_groups}${value.parent_management_group_id}" : local.empty_string)
  }
  azurerm_management_group_level_3 = {
    for key, value in local.es_landing_zones_map :
    key => value
    if contains(keys(azurerm_management_group.level_2), try(length(value.parent_management_group_id) > 0, false) ? "${local.provider_path.management_groups}${value.parent_management_group_id}" : local.empty_string)
  }
  azurerm_management_group_level_4 = {
    for key, value in local.es_landing_zones_map :
    key => value
    if contains(keys(azurerm_management_group.level_3), try(length(value.parent_management_group_id) > 0, false) ? "${local.provider_path.management_groups}${value.parent_management_group_id}" : local.empty_string)
  }
  azurerm_management_group_level_5 = {
    for key, value in local.es_landing_zones_map :
    key => value
    if contains(keys(azurerm_management_group.level_4), try(length(value.parent_management_group_id) > 0, false) ? "${local.provider_path.management_groups}${value.parent_management_group_id}" : local.empty_string)
  }
  azurerm_management_group_level_6 = {
    for key, value in local.es_landing_zones_map :
    key => value
    if contains(keys(azurerm_management_group.level_5), try(length(value.parent_management_group_id) > 0, false) ? "${local.provider_path.management_groups}${value.parent_management_group_id}" : local.empty_string)
  }
}