variable "hcloud_token" {
  description = "Hetzner Cloud API token"
  type        = string
  sensitive   = true
}

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "ssh_keys" {
  description = "List of SSH key names to attach to servers"
  type        = list(string)
}

variable "location" {
  description = "Hetzner Cloud location"
  type        = string
  default     = "nbg1"
}

variable "image" {
  description = "Server image to use"
  type        = string
  default     = "ubuntu-24.04"
}

variable "server_type" {
  description = "Hetzner server type"
  type        = string
  default     = "cpx21"
}

variable "network_cidr" {
  description = "Network CIDR"
  type        = string
  default     = "10.10.0.0/16"
}

variable "subnet_cidr" {
  description = "Subnet CIDR"
  type        = string
  default     = "10.10.1.0/24"
}

variable "network_zone" {
  description = "Hetzner network zone"
  type        = string
  default     = "eu-central"
}

variable "allowed_ssh_cidrs" {
  description = "CIDR blocks allowed for SSH (port 22)"
  type        = list(string)
}

variable "allowed_http_cidrs" {
  description = "CIDR blocks allowed for HTTP (port 80)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "allowed_https_cidrs" {
  description = "CIDR blocks allowed for HTTPS (port 443)"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "allowed_icmp_cidrs" {
  description = "CIDR blocks allowed for ICMP"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "nodes" {
  description = "Map of node definitions: key = node name suffix, value = { private_ip, server_type, labels }. server_type overrides the global default per node."
  type = map(object({
    private_ip   = string
    server_type  = optional(string)  # e.g. cx33, cx23 - overrides global server_type for this node
    labels       = optional(map(string), {})
  }))
}
