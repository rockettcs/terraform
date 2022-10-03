resource "aws_vpc" "capitalvia" {
  cidr_block           = var.cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "hyder"
  }
}
###publicsubnet
resource "aws_subnet" "publicsubnet-1" {
  vpc_id                  = aws_vpc.capitalvia.id
  cidr_block              = var.publicsubnet
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "needa"
  }
}
###privatesubnet
resource "aws_subnet" "privatesubnet-2" {
  vpc_id                  = aws_vpc.capitalvia.id
  cidr_block              = var.privatesubnet
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "needa2"
  }
}
###internetgateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.capitalvia.id

  tags = {
    Name = "tata-server"
  }
}
### route table
resource "aws_route_table" "chanu" {
  vpc_id = aws_vpc.capitalvia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "publicroutetable"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.publicsubnet-1.id
  route_table_id = aws_route_table.chanu.id
}
####routetable private
/*resource "aws_route_table" "chanu2" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "${var.privatesubnet}"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "privateroutetable"
  }
}
*/

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.capitalvia.id


  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["114.143.190.234/32", "114.143.190.233/32"]

  }

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["114.143.190.234/32", "114.143.190.233/32"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "hihghnhifj"
  }
}

resource "aws_db_subnet_group" "chaun" {
  name       = "main"
  subnet_ids = [aws_subnet.publicsubnet-1.id, aws_subnet.privatesubnet-2.id]

  tags = {
    Name = "My DB subnet group"
  }
}
