# Deploy additional Management Groups alongside Enterprise-scale core Management Groups.
custom_landing_zones = {
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