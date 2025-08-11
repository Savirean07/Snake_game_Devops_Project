output "vnet_id" {
  description = "ID of the Virtual Network"
  value       = module.network.vnet_id
}

output "subnet_ids" {
  description = "IDs of subnets"
  value       = module.network.subnet_ids
}

output "nsg_id" {
  description = "ID of the Network Security Group"
  value       = module.network.nsg_id
}

output "vm_ids" {
  description = "IDs of Azure VMs"
  value       = module.compute.vm_ids
}

output "vm_public_ips" {
  description = "Public IPs of Azure VMs"
  value       = module.compute.vm_public_ips
}

output "vm_private_ips" {
  description = "Private IPs of Azure VMs"
  value       = module.compute.vm_private_ips
}

output "azure_dashboard_url" {
  description = "Azure Portal Dashboard URL"
  value       = "https://portal.azure.com/#blade/HubsExtension/BrowseResource/resourceType/Microsoft.Portal%2Fdashboards"
}
