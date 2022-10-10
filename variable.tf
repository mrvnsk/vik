variable "vpc-cidr" {
  default     = "10.0.0.0/16"
  description = "VPC CIDR BLOCK"
  type        = string
}

variable "vpc-tag-name" {
  default     = "test_vpc"
  description = "VPC TAG NAME"
  type        = string
}

variable "public-subnet-1_CIDR" {
  default     = "10.0.0.0/24"
  description = "PUBLIC SUBNET-1 CIDR"
  type        = string
}

variable "public-subnet-2_CIDR" {
  default     = "10.0.1.0/24"
  description = "PUBLIC SUBNET-2 CIDR"
  type        = string
}

variable "Private-subnet-1_CIDR" {
  default     = "10.0.2.0/24"
  description = "PRIVATE SUBNET-1 CIDR"
  type        = string
}

variable "Private-subnet-2_CIDR" {
  default     = "10.0.3.0/24"
  description = "PRIVATE SUBNET-2 CIDR"
  type        = string
}

variable "ssh-location" {
  default     = "0.0.0.0/0"
  description = "IP Adress that can ssh into ec2 instance"
  type        = string
}
