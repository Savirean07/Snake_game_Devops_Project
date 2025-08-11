variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "location" {
  description = "Azure location for resources"
  type        = string
  default     = "eastus"
}

variable "vnet_cidr" {
  description = "CIDR block for VNet"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR blocks for subnets"
  type        = list(string)
}

variable "instance_size" {
  description = "Azure VM size"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for VM"
  type        = string
}

variable "admin_password" {
  description = "Admin password for VM (or use SSH key)"
  type        = string
  sensitive   = true
}

variable "instance_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 2
}
