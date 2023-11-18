provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "db" {
  ami             = "ami-06018068a18569ff2"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.webtraffic.name]
  tags = {
    Name = "DB Server"
  }

}

resource "aws_instance" "web" {
  ami             = "ami-06018068a18569ff2"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.webtraffic.name]
  tags = {
    Name = "Web Server"
  }
  user_data = file("server-script.sh")

}

resource "aws_eip" "web_ip" {
  instance = aws_instance.web.id
}

variable "ports" {
  type    = list(number)
  default = [80, 443]
}

resource "aws_security_group" "webtraffic" {
  name        = "Allow HTTP HTTPS"
  description = "Allow http and https traffic"

  dynamic "ingress" {
    for_each = toset(var.ports)
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = toset(var.ports)
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

}

output "PrivateIP" {
  value = aws_instance.db.private_ip
}

output "PublicIP" {
  value = aws_eip.web_ip.public_ip
}
