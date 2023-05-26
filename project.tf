provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "newvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "custom vpc"
  }

}

resource "aws_subnet" "newsubnet" {
  vpc_id            = aws_vpc.newvpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "custom subnet"
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.newvpc.id

}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.newvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
    tags = {
      Name = "custom route"
    }

  
}

resource "aws_route_table_association" "RTA" {
  subnet_id      = aws_subnet.newsubnet.id
  route_table_id = aws_route_table.RT.id

}

resource "aws_instance" "nginx" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  key_name      = "algooer"

  subnet_id                   = aws_subnet.newsubnet.id
  vpc_security_group_ids      = [aws_security_group.nginx_sg.id]
  associate_public_ip_address = true
}

resource "aws_security_group" "nginx_sg" {
  name   = "ssh and http"
  vpc_id = aws_vpc.newvpc.id
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
