output "instance_id" {
  value       = join("", aws_instance.bastion_instance.*.id)
  description = "Instance ID"
}

output "ssh_user" {
  value       = var.ssh_user
  description = "SSH user"
}

output "security_group_id" {
  value       = join("", aws_security_group.bastion_sg.*.id)
  description = "Security group ID"
}

output "role" {
  value       = join("", aws_iam_role.default.*.name)
  description = "Name of AWS IAM Role associated with the instance"
}

output "public_ip" {
  value       = join("", aws_instance.bastion_instance.*.public_ip)
  description = "Public IP of the instance (or EIP)"
}

output "private_ip" {
  value       = join("", aws_instance.bastion_instance.*.private_ip)
  description = "Private IP of the instance"
}
