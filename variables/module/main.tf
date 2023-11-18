provider "aws" {
    region = "ap-southeast-1"
  
}

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
  
}


module "ec2" {
    
    source = "./ec2"
    for_each = toset([ "dev", "test", "prod" ])

}