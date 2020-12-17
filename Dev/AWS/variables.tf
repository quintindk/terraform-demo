

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
variable "vpc_cidr_block" {
    default = "10.0.0.0/16"
}
variable "vpc_cidr_base" {
    default = "10.0"
}
variable "private_subnet_cidrs" {
  description = "CIDRs for the private subnets"
  default = {
    zone0 = ".1.0/24"
    zone1 = ".2.0/24"
    zone2 = ".3.0/24"
  }
}
variable "public_subnet_cidrs" {
  description = "CIDRs for the public subnets"
  default = {
    zone0 = ".4.0/24"
    zone1 = ".5.0/24"
    zone2 = ".6.0/24"
  }
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
##############################################################################