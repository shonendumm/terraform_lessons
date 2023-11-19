# configure terraform to store the state file in s3 backend

terraform {
  backend "s3" {
    key = "terraform/tfstate.tfstate" # folder path for saving the state file
    bucket = "soo-remote-backend-2023" # bucket created in advance
    region = "ap-southeast-1"
    access_key = ""
    secret_key = ""
  }
}

# cat ~/.aws/credentials to view credentials