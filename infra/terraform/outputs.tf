output "network_id" {
  description = "Hetzner network ID"
  value       = module.network.network_id
}

output "network_cidr" {
  description = "Network CIDR"
  value       = module.network.network_cidr
}

output "subnet_id" {
  description = "Subnet ID"
  value       = module.network.subnet_id
}

output "subnet_cidr" {
  description = "Subnet CIDR"
  value       = module.network.subnet_cidr
}

output "firewall_id" {
  description = "Firewall ID"
  value       = module.firewall.firewall_id
}

output "server_ids" {
  description = "Map of server IDs by node key"
  value       = module.servers.server_ids
}

output "server_public_ipv4" {
  description = "Map of public IPv4 addresses by node key"
  value       = module.servers.public_ipv4
}

output "server_private_ipv4" {
  description = "Map of private IPv4 addresses by node key"
  value       = module.servers.private_ipv4
}

output "server_names" {
  description = "Map of server names by node key"
  value       = module.servers.server_names
}
