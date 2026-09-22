
resource "aws_vpc" "my_vpc" {

  cidr_block = var.child_vpc_cidr
  tags = {
    Name = "${var.child_env}-vpc"
  }

}


resource "aws_subnet" "public_subnet" {

  count = length(var.child_public_cidr)

  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.child_public_cidr[count.index]
  map_public_ip_on_launch = true

  availability_zone = var.child_availability_zone[count.index]

  tags = {
    Name = "${var.child_env}- public-${count.index + 1}"
  }

}


resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.child_private_cidr
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.child_env}- private"
  }

}