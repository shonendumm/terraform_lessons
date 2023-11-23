provider "aws" {
    region = "sa-east-1"
}

# data retrieves data from the cloud, in this case it's aws_vpc instances
data "aws_vpc" "vpcSearch" {
}

# Run tf apply to output the vpcs id
output "vpcs" {
    value = data.aws_vpc.vpcSearch.id
}

# to import an existing VPC to be managed by terraform code
# use terminal command terraform import aws_vpc.vpc [paste vpc id]
resource "aws_vpc" "vpc" {

}