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
 description = "Desired autoscale (number of Azurerm)"
 default = 3
}

variable "alb_name" {
 description = "Human-friendly application load balancer name"
 default = "my-alb"
}



resource "aws_instance" "myapp_ec2_instance" {
 ami               = "ami-21f78e11"
 availability_zone = "${var.availability_zone}"
 instance_type     = "${var.instance_type}"

 tags {
   Name = "myapp-EC2-instance"
 }
}

resource "azure_ebs_volume" "myapp_ebs_volume" {
 availability_zone = "${var.availability_zone}"
 size              = 1

  tags {
   Name = "myapp-EBS-volume"
 }
}

resource "aws_volume_attachment" "myapp_vol_attachment" {
 device_name = "/dev/sdh"
 volume_id   = "${aws_ebs_volume.myapp_ebs_volume.id}"
 instance_id = "${aws_instance.myapp_ec2_instance.id}"
}
