provider "aws" {
    region = "ap-southeast-1"
  
}

variable "environment" {
    type = string
  
}


resource "aws_instance" "ec2" {
    ami = "ami-06018068a18569ff2"
    instance_type = "t2.micro"
    count = var.environment == "prod" ? 1:0
  
}