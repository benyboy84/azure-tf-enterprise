# The following locals are used to define the core Enterprise-scale Management Groups deployed and uses
# logic to determine the full Management Group deployment hierarchy.
locals {

  # Logic to auto-generate values for Management Groups.
  es_landing_zones_map = {
    for key, value in local.landing_zones :
    "${local.provider_path.management_groups}${key}" => {
      id                         = key
      display_name               = value.display_name
      parent_management_group_id = value.parent_management_group_id
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