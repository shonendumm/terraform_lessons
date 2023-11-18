provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "ec2" {
  ami             = "ami-06018068a18569ff2"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.webtraffic.name]

  tags = {
    Name = "soohian-ec2"
  }

}


resource "aws_security_group" "webtraffic" {
  name = "Allow HTTPS"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
