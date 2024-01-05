variable "region" {
  default = "us-east-2"
}

variable "personalip" {}

variable "ubuntu_ver" {
  default = "focal-20.04"
}

variable "aws_vpc_name" {
  default = "lesson4-vpc"
}

variable "cidr_subnet" {
  default = ".0"
}

variable "cidr_mask" {
  default = "/24"
}

variable "cidr_net" {
  default = "192.168.129"
}

variable "username" {
  default = ".0"
}

variable "from_port" {
  default = "8443"
}
variable "to_port" {
  default = "8444"
}

variable "aws_instance_size" {
  default = "t2.small"
}

variable "private_sshkey" {
  default = "/Users/jeff.schmitz/.ssh/id_rsa"
}
variable "public_sshkey" {
  default = "/Users/jeff.schmitz/.ssh/id_rsa.pub"
}

variable "hostfilename" {
  default = "myserverhostfile.txt"
}

