output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "subnet_ids" {
  value = [for s in azurerm_subnet.main : s.id]
}

output "nsg_id" {
  value = azurerm_network_security_group.main.id
}
