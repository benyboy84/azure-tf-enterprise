# The following output is used to ensure all Management Group
# data is returned to the root module.
output "azurerm_management_group" {
  value = {
    level_1 = azurerm_management_group.level_1
    level_2 = azurerm_management_group.level_2
    level_3 = azurerm_management_group.level_3
    level_4 = azurerm_management_group.level_4
    level_5 = azurerm_management_group.level_5
    level_6 = azurerm_management_group.level_6
  }
  description = "Returns the configuration data for all Management Groups created by this module."
}

# The following output is used to ensure all Management Group
# Subscription Association data is returned to the root module.
output "azurerm_management_group_subscription_association" {
  value = {
    enterprise_scale = azurerm_management_group_subscription_association.enterprise_scale
  }
  description = "Returns the configuration data for all Management Group Subscription Associations created by this module."
}