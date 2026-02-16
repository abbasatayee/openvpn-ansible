resource "hcloud_server" "main" {
  for_each = var.nodes

  name        = "${var.name_prefix}-${each.key}"
  server_type = coalesce(lookup(each.value, "server_type", null), var.server_type)
  image       = var.image
  location    = var.location

  ssh_keys = var.ssh_keys

  firewall_ids = [var.firewall_id]

  network {
    network_id = var.network_id
    ip         = each.value.private_ip
  }

  labels = lookup(each.value, "labels", {})
}
