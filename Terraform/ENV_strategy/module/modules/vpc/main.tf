resource "aws_vpc" "child_vpc" {

  cidr_block = var.child_vpc_cidr

  tags = {
    Name = "vpc- ${var.child_env}"
  }
}



resource "aws_subnet" "child_public_subnet" {
  count = length(var.child_public_cidr)

  map_public_ip_on_launch = true

  vpc_id = aws_vpc.child_vpc.id

  cidr_block        = var.child_public_cidr[count.index]
  availability_zone = var.child_availability_zone[count.index]

  tags = {
    Name = "${var.child_env}-public_subnet-${count.index}"
  }
}



resource "aws_subnet" "child_private_subnet" {
  count = length(var.child_private_cidr)

  vpc_id                  = aws_vpc.child_vpc.id
  map_public_ip_on_launch = false
  cidr_block              = var.child_private_cidr[count.index]
  availability_zone       = var.child_availability_zone[count.index]
  tags = {
    Name = "${var.child_env}-private_subnet-${count.index}"
  }
}


resource "aws_internet_gateway" "child_igw" {

  vpc_id = aws_vpc.child_vpc.id

  tags = {
    Name = "${var.child_env}- IGW"
  }
}



resource "aws_route_table" "child_public_RT" {

  vpc_id = aws_vpc.child_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.child_igw.id
  }

  tags = {
    Name = "${var.child_env}-Public-RT"
  }
}


resource "aws_route_table_association" "child_associate_Public_RT" {

  count = length(var.child_public_cidr)

  route_table_id = aws_route_table.child_public_RT.id
  subnet_id      = aws_subnet.child_public_subnet[count.index].id

}


resource "aws_eip" "child_eip" {
  count = 2

  domain = "vpc"

  tags = {
    Name = "nat-gateway-eip-${count.index}"
  }
}


resource "aws_nat_gateway" "child_nat" {

  count         = 2
  allocation_id = aws_eip.child_eip[count.index].id
  subnet_id     = aws_subnet.child_public_subnet[count.index].id

  tags = {
    Name = "${var.child_env}-Nat-${count.index}"
  }

}

resource "aws_route_table" "child-private_RT" {
  count  = 2
  vpc_id = aws_vpc.child_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.child_nat[count.index].id
  }

  tags = {
    Name = "${var.child_env}-Private-RT-${count.index}"
  }
}

resource "aws_route_table_association" "child_associate_Private_RT" {
  count = 2

  subnet_id      = aws_subnet.child_private_subnet[count.index].id
  route_table_id = aws_route_table.child-private_RT[count.index].id
}