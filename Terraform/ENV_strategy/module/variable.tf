variable "region" {
  type = string
}

variable "root_vpc_cidr" {
  type = string
}

variable "root_private_cidr" {
  type = list(string)
}

variable "root_public_cidr" {
  type = list(string)
}

variable "root_availability_zone" {
  type = list(string)
}

variable "root_env" {
  type = string
}