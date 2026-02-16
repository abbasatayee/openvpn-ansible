variable "name" {
  description = "Name prefix for the network"
  type        = string
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
