output "vm_ids" {
  value = [for vm in azurerm_linux_virtual_machine.main : vm.id]
}

output "vm_public_ips" {
  value = [for ip in azurerm_public_ip.main : ip.ip_address]
}

output "vm_private_ips" {
  value = [for nic in azurerm_network_interface.main : nic.private_ip_address]
}
