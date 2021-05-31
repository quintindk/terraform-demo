variable "instance_type" {
 description = "Type of EC2 instance to use"
 default = "t2.small"
}

variable "instance_types" {
 type    = "map"
 default = {
   "dev" = "t2.small"
   "prod" = "t3.large"
 }
}

variable "autoscale_min" {
 description= "The minimum number of EC2 instances"
 default = 2
}

variable "autoscale_max" {
 description= "The maximum number of EC2 instances"
 default = 5
}

variable "autoscale_desired" {
 description = "Desired autoscale (number of EC2)"
 default = 3
}

variable "alb_name" {
 description = "Human-friendly application load balancer name"
 default = "my-alb"
}
