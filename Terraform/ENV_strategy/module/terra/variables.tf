variable "region" {
  type = string
}

variable "root_vpc_cidr" {
  type = string
}

variable "root_public_cidr" {
  type = list(string)
}

variable "root_availability_zone" {
  type = list(string)
}

variable "root_private_cidr" {
  type = string
}

variable "root_env" {
  type = string
}

variable "root_ami" {
  type = string
}

variable "root_instance_type" {
  type = string
}

variable "root_key_name" {
  type = string
}

