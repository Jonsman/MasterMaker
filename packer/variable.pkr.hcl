// vSphere Credentials
variable "vsphere_endpoint" {
  type        = string
  description = "The fully qualified domain name or IP address of the vCenter Server instance."
}

variable "vsphere_username" {
  type        = string
  description = "The username to login to the vCenter Server instance."
  sensitive   = true
}

variable "vsphere_password" {
  type        = string
  description = "The password for the login to the vCenter Server instance."
  sensitive   = true
}

// vSphere Settings
variable "vsphere_datacenter" {
  type        = string
  description = "The name of the target vSphere datacenter."
  default     = ""
}

variable "vsphere_cluster" {
  type        = string
  description = "The name of the target vSphere cluster."
  default     = ""
}

variable "vsphere_host" {
  type        = string
  description = "The name of the target ESXi host."
  default     = ""
}

variable "vsphere_datastore" {
  type        = string
  description = "The name of the target vSphere datastore."
}

variable "vsphere_network" {
  type        = string
  description = "The name of the target vSphere network segment."
}

variable "windows_iso_path" {
  type        = string
  description = "The path to the Windows ISO."
}

variable "vmtools_iso_path" {
  type        = string
  description = "The path to the VMware Tools ISO."
}

// Netshare User
variable "netshare_user" {
  type        = string
  description = "The username to login to the netshare."
  sensitive   = true
}

variable "netshare_pass" {
  type        = string
  description = "The password for the login to the netshare."
  sensitive   = true
}