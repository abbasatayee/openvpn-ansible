output "network_id" {
  description = "Hetzner network ID"
  value       = hcloud_network.main.id
}

output "subnet_id" {
  description = "Subnet ID"
  value       = hcloud_network_subnet.main.id
}

output "network_cidr" {
  description = "Network CIDR"
  value       = hcloud_network.main.ip_range
}

output "subnet_cidr" {
  description = "Subnet CIDR"
  value       = hcloud_network_subnet.main.ip_range
}
