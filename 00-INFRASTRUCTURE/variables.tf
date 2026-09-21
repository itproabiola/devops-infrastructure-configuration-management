variable "aws_region" {
  description = "AWS region for infrastructure deployment"
  type        = string
  default     = "ca-central-1"
}

variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
  default     = "multi-os-servers"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "practice"
}

variable "key_pair_name" {
  description = "Existing EC2 key pair name"
  type        = string
  default     = "Aug16"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "volume_size" {
  description = "Root EBS volume size in GB"
  type        = number
  default     = 20
}

variable "amazon_linux_count" {
  description = "Number of Amazon Linux instances"
  type        = number
  default     = 1
}

variable "ubuntu_count" {
  description = "Number of Ubuntu instances"
  type        = number
  default     = 1
}

variable "vpc_id" {
  description = "Existing VPC ID"
  type        = string
  default     = "vpc-0dfa52713b2830780"
}

variable "subnet_ids" {
  description = "Existing subnet IDs"
  type        = list(string)
  default = [
    "subnet-0e30671ee327d769a",
    "subnet-088160a2633aa374b"
  ]
}

variable "ubuntu_ami" {
  description = "Ubuntu 24.04 LTS AMI for ca-central-1"
  type        = string
  default     = "ami-05d7d46c2c4b0dbf8"
}

variable "amazon_linux_ami" {
  description = "Amazon Linux AMI for ca-central-1"
  type        = string
  default     = "ami-029c5475368ac7adc"
}
