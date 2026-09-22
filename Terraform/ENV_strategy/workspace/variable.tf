variable "ami_id" {
  type = map(string)
  default = {
    dev   = "ami-0b6d9d3d33ba97d99"
    stage = "ami-0fef201115eefe936"
    prod  = "ami-00adafae70b8029d8"
  }
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type = map(string)

  default = {
    dev   = "t3.small"
    stage = "t3.small"
    prod  = "t3.micro"
  }

}