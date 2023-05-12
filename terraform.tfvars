# The root_parent_id is used to specify where to set the root for all Landing Zone deployments. Usually the Tenant ID when deploying the core Enterprise-scale Landing Zones.
root_parent_id = "0f9829d3-a628-4f2b-a3ac-58e0740d27ae"

# Will set a custom Name (ID) value for the Enterprise-scale \"root\" Management Group, and append this to the ID for all core Enterprise-scale Management Groups."
root_id = "mg-cti"

# Will set a custom Display Name value for the Enterprise-scale \"root\" Management Group.
root_name = "ConseilsTI"

# Deploy additional Management Groups alongside Enterprise-scale core Management Groups.
custom_landing_zones = {
  "${local.root_id}-finance" = {
    display_name               = "Finance"
    parent_management_group_id = "${local.root_id}-landing-zones"
  },
  "${local.root_id}-finance-prod" = {
    display_name               = "Finance Production"
    parent_management_group_id = "${local.root_id}-finance"
  },
  "${local.root_id}-finance-nprod" = {
    display_name               = "Finance Non-Production"
    parent_management_group_id = "${local.root_id}-finance"
  },
}
  