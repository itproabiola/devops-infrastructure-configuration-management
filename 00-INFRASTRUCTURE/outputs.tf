output "amazon_linux_instances" {
  description = "Details of Amazon Linux instances"
  value = {
    for instance in aws_instance.amazon_linux_servers :
    instance.tags.Name => {
      id          = instance.id
      public_ip   = instance.public_ip
      private_ip  = instance.private_ip
      az          = instance.availability_zone
      subnet_id   = instance.subnet_id
      eip         = try(aws_eip.amazon_linux_eip[index(aws_instance.amazon_linux_servers, instance)].public_ip, null)
      ssh_command = "ssh -i ~/.ssh/${var.key_pair_name}.pem ec2-user@${instance.public_ip}"
    }
  }
}

output "ubuntu_instances" {
  description = "Details of Ubuntu instances"
  value = {
    for instance in aws_instance.ubuntu_servers :
    instance.tags.Name => {
      id          = instance.id
      public_ip   = instance.public_ip
      private_ip  = instance.private_ip
      az          = instance.availability_zone
      subnet_id   = instance.subnet_id
      eip         = try(aws_eip.ubuntu_eip[index(aws_instance.ubuntu_servers, instance)].public_ip, null)
      ssh_command = "ssh -i ~/.ssh/${var.key_pair_name}.pem ubuntu@${instance.public_ip}"
    }
  }
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.server_sg.id
}

output "total_instances_created" {
  description = "Total number of instances created"
  value       = length(aws_instance.amazon_linux_servers) + length(aws_instance.ubuntu_servers)
}

output "instance_distribution" {
  description = "Distribution of instances across subnets"
  value = {
    amazon_linux_by_subnet = {
      for subnet in var.subnet_ids :
      subnet => [
        for instance in aws_instance.amazon_linux_servers :
        instance.tags.Name if instance.subnet_id == subnet
      ]
    }
    ubuntu_by_subnet = {
      for subnet in var.subnet_ids :
      subnet => [
        for instance in aws_instance.ubuntu_servers :
        instance.tags.Name if instance.subnet_id == subnet
      ]
    }
  }
}

output "quick_ssh_commands" {
  description = "Quick SSH commands for all instances"
  value = {
    amazon_linux = [
      for instance in aws_instance.amazon_linux_servers :
      "ssh -i ~/.ssh/${var.key_pair_name}.pem ec2-user@${instance.public_ip}  # ${instance.tags.Name}"
    ]
    ubuntu = [
      for instance in aws_instance.ubuntu_servers :
      "ssh -i ~/.ssh/${var.key_pair_name}.pem ubuntu@${instance.public_ip}  # ${instance.tags.Name}"
    ]
  }
}

output "instance_summary" {
  description = "Summary of created instances"
  value = {
    amazon_linux_count    = length(aws_instance.amazon_linux_servers)
    ubuntu_count          = length(aws_instance.ubuntu_servers)
    total_count           = length(aws_instance.amazon_linux_servers) + length(aws_instance.ubuntu_servers)
    security_group        = aws_security_group.server_sg.id
    vpc_id                = var.vpc_id
    subnets_used          = var.subnet_ids
    ubuntu_ami_used       = var.ubuntu_ami
    amazon_linux_ami_used = var.amazon_linux_ami
  }
}