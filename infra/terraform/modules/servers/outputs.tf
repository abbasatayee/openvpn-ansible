output "server_ids" {
  description = "Map of server IDs by node key"
  value       = { for k, s in hcloud_server.main : k => tostring(s.id) }
}

output "public_ipv4" {
  description = "Map of public IPv4 addresses by node key"
  value       = { for k, s in hcloud_server.main : k => s.ipv4_address }
}

output "private_ipv4" {
  description = "Map of private IPv4 addresses by node key"
  value       = { for k, s in hcloud_server.main : k => one(s.network).ip }
}

output "server_names" {
  description = "Map of server names by node key"
  value       = { for k, s in hcloud_server.main : k => s.name }
}
