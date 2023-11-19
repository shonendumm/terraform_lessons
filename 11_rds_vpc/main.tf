# https://developer.hashicorp.com/terraform/tutorials/aws/aws-rds#publicly_accessible

provider "aws" {
    region = var.region
}

# Fetch data about available azs from aws
data "aws_availability_zones" "available" {}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.2.0"

  name                 = "education"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true
}

# designates a collection of subnets for rds instance to be provisioned in
# uses subnets created by the vpc
resource "aws_db_subnet_group" "education" {
  name       = "education"
  subnet_ids = module.vpc.public_subnets

  tags = {
    Name = "Education"
  }
}

resource "aws_security_group" "rds" {
  name   = "education_rds"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "education_rds"
  }
}


resource "aws_db_instance" "education" {
  identifier             = "education"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "15.4"
  username               = "edu"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.education.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.education.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}

# Custom parameter groups are optional, and AWS will create the instance using a default parameter group 
# if you do not supply one. However, you cannot modify the settings of a default parameter group, 
# and changing the associated parameter group for an AWS instance always requires a reboot, 
# so it is best to use a custom one to support modifications over the RDS life cycle.
resource "aws_db_parameter_group" "education" {
  name   = "education"
  family = "postgres15"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}