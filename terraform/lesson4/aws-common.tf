
resource "aws_vpc" "vpc" {
  cidr_block           = "${var.cidr_net}${var.cidr_subnet}${var.cidr_mask}"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.aws_vpc_name
  }
}

resource "aws_key_pair" "auth" {
  key_name   = "SEClassKEYNAME"
  public_key = file("${var.public_sshkey}")
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "var.aws_vpc_name-AWSGW"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_vpc.vpc.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_subnet" "first_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "${var.cidr_net}.0/26"

  tags = {
    Name = "${var.aws_vpc_name}-first-subnet"
  }
}


resource "aws_security_group" "first_sg" {
  name        = "first-sg"
  description = "Allow local traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16", "142.215.23.80/28"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.personalip}/32"]
  }
  ingress {
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "${var.aws_vpc_name}-first-sg"
    email = var.username
  }
}