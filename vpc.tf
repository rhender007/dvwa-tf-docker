# vpc.tf
resource "aws_vpc" "dvwa_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "dvwa_subnet" {
  vpc_id            = aws_vpc.dvwa_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "dvwa_igw" {
  vpc_id = aws_vpc.dvwa_vpc.id
}

resource "aws_route_table" "dvwa_route_table" {
  vpc_id = aws_vpc.dvwa_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dvwa_igw.id
  }
}

resource "aws_route_table_association" "dvwa_route_table_association" {
  subnet_id      = aws_subnet.dvwa_subnet.id
  route_table_id = aws_route_table.dvwa_route_table.id
}
