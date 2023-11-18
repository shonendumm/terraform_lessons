provider "aws" {
    region = "ap-southeast-1"
  
}

variable "environment" {
    type = string
  
}

variable "number_of_servers" {
    type = list(string)
}


resource "aws_instance" "ec2" {
    ami = "ami-06018068a18569ff2"
    instance_type = "t2.micro"
    for_each = var.environment == "prod" ? toset(var.number_of_servers): toset(var.number_of_servers)

    # count = var.environment == "prod" ? 1:0
  
}

# To pass in variable files during command line execution:
# run terraform plan -var-file="prod.tfvars"
# or
# run terraform plan -var-file="test.tfvars"