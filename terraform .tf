provider "aws" {
  region     = "ap-south-1"
  access_key = "awskey"
  secret_key = "awssecret key"
}

resource "aws_instance" "Adfx"{

  ami             = "ami-07eaf27c7c4a884cf"
  instance_type   = "t3.micro"
  subnet_id = aws_subnet.publicsubnet-1.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  key_name        = "k8'S"

  tags = {
    Name = "chanu-latest"
    Name = "hero"
  }
}
