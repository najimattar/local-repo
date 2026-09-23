variable "ami_id" {
  type = string

}

variable "instance_type" {
  type = map(string)

}

variable "security_group" {
  type = map(list(string))
}