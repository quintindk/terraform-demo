

################################ Global ###########################################
variable "global_tags" {
  description = "All Cloud network global tags for terraform demo"
  type = map(string)
  default = {
    "Author" = "Leon Mwandiringa",
    "Environment" = "Development",
    "Project" = "terraform demo"
  }
}
#######################################################################################


############################# VPC CONFIG ##############################################
variable "access_key" {}
variable "secret_key" {}

variable "aws_region" {
    default = "us-east-2"
}
variable "aws_azs" {
  description = "comma separated string of availability zones in order of precedence"
  default     = "us-east-2a"
}
variable "az_count" {
  description = "number of active availability zones in VPC"
  default     = "1"
}
variable "vpc_cidr_block_1" {
    default = "10.0.0.0/16"
}
variable "vpc_cidr_block_2" {
    default = "10.1.0.0/16"
}
variable "vpc_cidr_base_1" {
    default = "10.0"
}
variable "vpc_cidr_base_2" {
    default = "10.1"
}
variable "private_subnet_cidrs_1" {
  description = "CIDRs for the private subnets"
  default = {
    zone0 = ".1.0/24"
    zone1 = ".2.0/24"
    zone2 = ".3.0/24"
  }
}
variable "private_subnet_cidrs_2" {
  description = "CIDRs for the private subnets"
  default = {
    zone0 = ".4.0/24"
    zone1 = ".5.0/24"
    zone2 = ".6.0/24"
  }
}
variable "public_subnet_cidrs_1" {
  description = "CIDRs for the public subnets"
  default = {
    zone0 = ".7.0/24"
    zone1 = ".8.0/24"
    zone2 = ".9.0/24"
  }
}
variable "public_subnet_cidrs_2" {
  description = "CIDRs for the public subnets"
  default = {
    zone0 = ".10.0/24"
    zone1 = ".11.0/24"
    zone2 = ".12.0/24"
  }
}
variable "private_inbound_acl_rules" {
  description = "Private subnets inbound network ACLs"

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "private_outbound_acl_rules" {
  description = "Private subnets outbound network ACLs"

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}
variable "public_inbound_acl_rules" {
  description = "Public subnets inbound network ACLs"

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "public_outbound_acl_rules" {
  description = "Public subnets outbound network ACLs"

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}
variable "default_sg_rules_ingress" {
  description = "List of maps of default seurity group rules ingress"
  type        = list(map(string))

  default = [
    {
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

variable "default_sg_rules_egress" {
  description = "List of maps of default seurity group rules egress"
  type        = list(map(string))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}
variable "vpc_instance_tenancy" {
  default = "default"
}
variable "vpc_enable_dns_support" {
  default = "true"
}
variable "vpc_enable_dns_hostnames" {
  default = "true"
}
variable "vpc_enable_classiclink" {
  default = "false"
}
##################################################################################



################################### storage ######################################
variable "s3_storage_name" {
  default = "terraform-demo"
}
##################################################################################




#################################### compute #####################################
variable "instance_type" {
  default = "t2.micro"
}
variable "ssh_user" {
  default = "ec2user"
}
variable "ami" {
  default = "mi-084ef34fdfdd7384c"
}
variable "key_name" {
  default = "techadon_keys"
}
variable "compute_sg_rules_egress" {
  description = "List of maps of default seurity group rules egress"
  type        = list(map(string))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}
variable "compute_sg_rules_ingress" {
  description = "List of maps of default seurity group rules ingress"
  type        = list(map(string))

  default = [
    {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "102.182.111.111/32"//was using personal ip for ssh tests
    },
  ]
}
#################################################################################