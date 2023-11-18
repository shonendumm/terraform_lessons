provider "aws" {
  region = "ap-southeast-1"
}


variable "number_of_instances" {
    type = number
    default = 2
}


resource "aws_instance" "ec2" {
  ami           = "ami-06018068a18569ff2"
  instance_type = "t2.micro"
  for_each = toset([for i in range(var.number_of_instances): "item${i}"])
  tags = {
    Name = each.value
  }
}

# Encounter error when I tried to create the list as a variable:
# [for i in range(var.number_of_instances): "item${i}"]
