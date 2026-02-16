module "network" {
  source = "./modules/network"

  name         = var.name_prefix
  network_cidr = var.network_cidr
  subnet_cidr  = var.subnet_cidr
  network_zone = var.network_zone
}

module "firewall" {
  source = "./modules/firewall"

  name                = var.name_prefix
  allowed_ssh_cidrs   = var.allowed_ssh_cidrs
  allowed_http_cidrs  = var.allowed_http_cidrs
  allowed_https_cidrs = var.allowed_https_cidrs
  allowed_icmp_cidrs  = var.allowed_icmp_cidrs
}

module "servers" {
  source = "./modules/servers"

  name_prefix = var.name_prefix
  location    = var.location
  image       = var.image
  server_type = var.server_type
  ssh_keys = var.ssh_keys
  firewall_id = module.firewall.firewall_id
  network_id  = module.network.network_id
  nodes       = var.nodes
}
