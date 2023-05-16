landing_zones = {

  # Mandatory core Enterprise-scale Management Groups
  mg = {
    display_name               = "Conseils TI"
    parent_management_group_id = "0f9829d3-a628-4f2b-a3ac-58e0740d27ae" # The root_parent_id is used to specify where to set the root for all Landing Zone deployments. Usually the Tenant ID when deploying the core Enterprise-scale Landing Zones.
  },
  "mg-decommissioned" = {
    display_name               = "Decommissioned"
    parent_management_group_id = local.root_id
  },
  "mg-sandboxes" = {
    display_name               = "Sandboxes"
    parent_management_group_id = local.root_id
  },
  "mg-landing-zones" = {
    display_name               = "Landing Zones"
    parent_management_group_id = local.root_id
  },
  "mg-platform" = {
    display_name               = "Platform"
    parent_management_group_id = local.root_id
  },
  "mg-connectivity" = {
    display_name               = "Connectivity"
    parent_management_group_id = "${local.root_id}-platform"
  },
  "mg-management" = {
    display_name               = "Management"
    parent_management_group_id = "${local.root_id}-platform"
  },
  "mg-identity" = {
    display_name               = "Identity"
    parent_management_group_id = "${local.root_id}-platform"
  },
  # Deploy additional Management Groups alongside Enterprise-scale core Management Groups.
  "mg-finance" = {
    display_name               = "Finance"
    parent_management_group_id = "mg-landing-zones"
  },
  "mg-finance-prod" = {
    display_name               = "Finance Production"
    parent_management_group_id = "mg-finance"
  },
  "mg-finance-nprod" = {
    display_name               = "Finance Non-Production"
    parent_management_group_id = "mg-finance"
  },
}
  