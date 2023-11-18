provider "aws" {
  region = "ap-southeast-1"
}

module "db" {
    source = "./ec2"
    ec2name = "db" # var.ec2name
    securitygroups = [module.securityGroup.name]
    userdata = null
}

module "web" {
    source = "./ec2"
    ec2name = "web"
    securitygroups = [module.securityGroup.name]
    condition = true
    userdata = "server-script.sh"
}

module "securityGroup" {
    source = "./security_group"
    ports = [80, 443]
    cidr_blocks = ["0.0.0.0/0"]
}

module "aws_eip" {
    source = "./eip"
    instance_id = module.web.instance_id
}


output "db_instance_id" {
    value = module.db.instance_id
}

output "web_instance_id" {
    value = module.web.instance_id
}


output "public_ip" {
    value = module.aws_eip.public_ip
}



