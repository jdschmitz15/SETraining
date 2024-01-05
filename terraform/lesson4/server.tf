# Create public IPs

data "aws_ami" "ubuntu" {
  owners      = ["aws-marketplace"]
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-${var.ubuntu_ver}-amd64*"]
  }

}


resource "aws_instance" "server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.aws_instance_size

  vpc_security_group_ids      = [aws_security_group.first_sg.id]
  subnet_id                   = aws_subnet.first_subnet.id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.auth.key_name
  root_block_device {
    delete_on_termination = true
    volume_size           = 20
    volume_type           = "gp2"
  }
  provisioner "remote-exec" {
    inline = [
      "ls -l",

    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${var.private_sshkey}")
      host        = self.public_ip
    }
  }

  tags = {
    Name = "${var.aws_vpc_name}-Server"
  }
}


resource "null_resource" "hostsfile" {
  provisioner "local-exec" {
    command = "echo [snc] > ${var.hostfilename}"
    }
    
    provisioner "local-exec" {
    command = "echo mysnc ansible_host=${aws_instance.server.private_ip} ansible_user=centos >> ${var.hostfilename}"
    }
    provisioner "local-exec" {
    command = "echo [snc-public] >> ${var.hostfilename}"
    }
    provisioner "local-exec" {
    command = "echo mysnc-public ansible_host=${aws_instance.server.public_ip} ansible_user=centos >> ${var.hostfilename}"
    }
    provisioner "local-exec" {
    command = "echo [server:children] >> ${var.hostfilename}"
    }
    provisioner "local-exec" {
    command = "echo snc >> ${var.hostfilename}"
    }
    provisioner "local-exec" {
    command = "echo snc-public >> ${var.hostfilename}"
    }
  

  depends_on = [aws_instance.server]
}

