provider "aws" {
    region = "sa-east-1"
}

data "aws_vpc" "vpcSearch" {
}

# Run tf apply to output the vpcs id
output "vpcs" {
    value = data.aws_vpc.vpcSearch.id
}

# to import an existing VPC for below
# use terminal command terraform import aws_vpc.vpc [paste vpc id]
resource "aws_vpc" "vpc" {

}