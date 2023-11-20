provider "aws" {
    region = "ap-southeast-1"
}

module "ec2" {
    source = "./ec2"
    server_names = ["server1" , "server2", "server3"]
}
