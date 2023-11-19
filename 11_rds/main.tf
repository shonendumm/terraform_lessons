provider "aws" {
  region = "ap-southeast-1"
}

variable "secret" {
  type = object({
    username = string
    password = string
  })
}

resource "aws_db_instance" "myRDS" {
  db_name             = "mydb"
  identifier          = "soohian-mariadb"
  engine              = "mariadb"
  engine_version      = "10.6.10"
  instance_class      = "db.t2.micro"
  username            = var.secret.username
  password            = var.secret.password
  port                = 3306
  allocated_storage   = 20
  skip_final_snapshot = true
}

# Note, secret.tfvars provides the username and password variables
# To pass in at cli, use terraform -var-file="secret.tfvars"
# Also, add secret* to .gitignore file

# Example for secret.tfvars file:
# secret = {
#     username = "user123"
#     password = "thisisapassword"
# }