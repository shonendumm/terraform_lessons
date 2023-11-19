variable "region" {
    default = "ap-southeast-1"
}

# Sensitive true tells Terraform to hide the password from the output during Terraform operations. 
# However, Terraform will store the password in plaintext in the state file.
variable db_password {
    description = "rds root user password"
    sensitive = true
}

# Set the db_password as an environment variable, else it will prompt you during terraform apply
# export TF_VAR_db_password="hashicorp"