# how to pass in values
variable "ec2name" {
    type = string
}


resource "aws_instance" "ec2" {
  ami             = "ami-06018068a18569ff2"
  instance_type   = "t2.micro"
  tags = {
    Name = var.ec2name
  }
}