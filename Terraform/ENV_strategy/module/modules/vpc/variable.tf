variable "child_vpc_cidr" {
  description = "ading cidr for child module vpc"
  type        = string
}

variable "child_public_cidr" {
  description = "adding ciddr for public subnet"
  type        = list(string)
}

variable "child_availability_zone" {
  description = "adding ciddr for public subnet"
  type        = list(string)
}

variable "child_private_cidr" {
  description = "adding ciddr for public subnet"
  type        = list(string)
}

variable "child_env" {
  description = "adding environment tag"
  type        = string
}