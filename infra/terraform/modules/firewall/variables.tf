variable "name" {
  description = "Firewall name"
  type        = string
}

variable "allowed_ssh_cidrs" {
  description = "CIDR blocks allowed for SSH (port 22)"
  type        = list(string)
}

variable "allowed_http_cidrs" {
  description = "CIDR blocks allowed for HTTP (port 80)"
  type        = list(string)
}

variable "allowed_https_cidrs" {
  description = "CIDR blocks allowed for HTTPS (port 443)"
  type        = list(string)
}

variable "allowed_icmp_cidrs" {
  description = "CIDR blocks allowed for ICMP"
  type        = list(string)
}
