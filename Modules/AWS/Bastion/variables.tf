
variable "global_tags" {}
variable "vpc_id" {}
variable "key_name" {}
variable "subnets" {}
variable "bastion_sg_rules_ingress" {}
variable "bastion_sg_rules_egress" {}
variable "hostname" {}
variable "region" {
  type        = string
  description = "AWS region"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of Availability Zones where subnets will be created"
}

variable "zone_id" {
  type        = string
  default     = "bst"
  description = "Route53 DNS Zone ID"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Elastic cache instance type"
}

variable "ami" {
  type        = string
  default     = "ami-084ef34fdfdd7384c"
  description = "AMI to use"
}

variable "user_data" {}

variable "ssh_user" {
  type        = string
  description = "Default SSH user for this AMI. e.g. `ec2user` for Amazon Linux and `ubuntu` for Ubuntu systems"
}
variable "default_security_group" {}
variable "ingress_security_groups" {}

variable "egress_security_groups" {}

variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "A list of CIDR blocks allowed to connect"

  default = [
    "0.0.0.0/0",
  ]
}

variable "root_block_device_encrypted" {
  type        = bool
  default     = false
  description = "Whether to encrypt the root block device"
}

variable "root_block_device_volume_size" {
  type        = number
  default     = 8
  description = "The volume size (in GiB) to provision for the root block device. It cannot be smaller than the AMI it refers to."
}

variable "metadata_http_endpoint_enabled" {
  type        = bool
  default     = true
  description = "Whether the metadata service is available"
}

variable "metadata_http_put_response_hop_limit" {
  type        = number
  default     = 1
  description = "The desired HTTP PUT response hop limit (between 1 and 64) for instance metadata requests."
}

variable "metadata_http_tokens_required" {
  type        = bool
  default     = false
  description = "Whether or not the metadata service requires session tokens, also referred to as Instance Metadata Service Version 2."
}

variable "associate_public_ip_address" {
  type        = bool
  default     = true
  description = "Whether to associate public IP to the instance."
}

