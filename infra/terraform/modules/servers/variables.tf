variable "name_prefix" {
  description = "Prefix for server names"
  type        = string
}

variable "location" {
  description = "Hetzner Cloud location"
  type        = string
  default     = "nbg1"
}

variable "image" {
  description = "Server image"
  type        = string
  default     = "ubuntu-24.04"
}

variable "server_type" {
  description = "Hetzner server type"
  type        = string
  default     = "cpx21"
}

variable "ssh_keys" {
  description = "List of SSH key names"
  type        = list(string)
}

variable "firewall_id" {
  description = "Firewall ID to attach"
  type        = number
}

variable "network_id" {
  description = "Network ID to attach"
  type        = number
}

variable "nodes" {
  description = "Map of node definitions: key = node name suffix, value = { private_ip, server_type, labels }"
  type = map(object({
    private_ip  = string
    server_type = optional(string)  # e.g. cx33, cx23 - overrides global for this node
    labels      = optional(map(string), {})
  }))
}
