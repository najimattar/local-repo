variable "child_vpc_cidr" {
  type = string
}

variable "child_public_cidr" {
  type = list(string)
}

variable "child_availability_zone" {
  type = list(string)
}

variable "child_private_cidr" {
  type = string
}

variable "child_env" {
  type = string
}