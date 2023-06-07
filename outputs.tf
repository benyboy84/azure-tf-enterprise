output "azurerm_management_group" {
  value = {
    level_1 = azurerm_management_group.level_1
    level_2 = azurerm_management_group.level_2
    level_3 = azurerm_management_group.level_3
    level_4 = azurerm_management_group.level_4
    level_5 = azurerm_management_group.level_5
    level_6 = azurerm_management_group.level_6
  }
  description = "Returns the configuration data for all Management Groups created."
}
