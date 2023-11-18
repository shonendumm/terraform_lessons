provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "DBserver" {
  ami             = "ami-06018068a18569ff2"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.webtraffic.name]
}

output "privateIP_DBserver" {
  value = aws_instance.DBserver.private_ip
}

resource "aws_instance" "Webserver" {
  ami             = "ami-06018068a18569ff2"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.webtraffic.name]

  user_data = file("server-script.sh")
}

resource "aws_eip" "eip" {
  instance = aws_instance.Webserver.id

}

output "Public_IP_Webserver" {
  value = aws_eip.eip.public_ip
}

variable "ports" {
  type    = list(number)
  default = [443, 80]

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
