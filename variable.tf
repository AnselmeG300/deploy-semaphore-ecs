variable "vpc_name" {
  description = "The name of the VPC being created."
  type        = string
  default     = "EAZYTraining VPC infrastructure"
}

variable "size" {
  description = "Size of  EBS."
  type        = number
  default     = 100
}

variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "activated_admin_bd" {
  type    = bool
  default = true
}

variable "activated_auto_scaling" {
  type    = bool
  default = true
}

variable "certficate_ssl" {
  type    = string
  default = ""
}

variable "snapshot_id" {
  type    = string
  default = "snap-03c617c53e1a4e558"
}
