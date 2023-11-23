provider "aws" {
    region = "ap-southeast-1"
  
}


resource "aws_default_vpc" "default" {
    force_destroy = true
    tags = {
    Name = "Default VPC"
  }
}

variable "number_of_servers" {
    type = number
}

resource "aws_instance" "ec2" {
    ami = "ami-06018068a18569ff2"
    instance_type = "t2.micro"
    count = var.number_of_servers

    depends_on = [aws_default_vpc.default]
    
}