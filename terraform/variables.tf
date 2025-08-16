variable "virtual_environment_endpoint" {
  description = "Proxmox API URL"
  type = string
}

variable "virtual_environment_api_token" {
  description = "Proxmox API Token ID and Proxmox API Secret Key"
  type = string
}

variable "gateway_ip" {
  description = "Gateway IP"
  type = string
}

variable "master_ip" {
  description = "IP for Master VM"
  type = string
}

variable "worker_ips" {
  description = "List containing Worker VM IPs"
  type = list(string)
}