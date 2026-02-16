resource "hcloud_firewall" "main" {
  name = var.name

  dynamic "rule" {
    for_each = length(var.allowed_ssh_cidrs) > 0 ? [1] : []
    content {
      direction  = "in"
      protocol   = "tcp"
      port       = "22"
      source_ips = var.allowed_ssh_cidrs
    }
  }

  dynamic "rule" {
    for_each = length(var.allowed_http_cidrs) > 0 ? [1] : []
    content {
      direction  = "in"
      protocol   = "tcp"
      port       = "80"
      source_ips = var.allowed_http_cidrs
    }
  }

  dynamic "rule" {
    for_each = length(var.allowed_https_cidrs) > 0 ? [1] : []
    content {
      direction  = "in"
      protocol   = "tcp"
      port       = "443"
      source_ips = var.allowed_https_cidrs
    }
  }

  dynamic "rule" {
    for_each = length(var.allowed_icmp_cidrs) > 0 ? [1] : []
    content {
      direction  = "in"
      protocol   = "icmp"
      source_ips = var.allowed_icmp_cidrs
    }
  }
}
