provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "ec2" {
  ami = "ami-06018068a18569ff2"
  instance_type = "t2.micro"

  tags = {
    Name = "soohian-ec2"
  }

}

resource "aws_eip" "elasticip" {
    instance = aws_instance.ec2.id
}

output "EIP" {
    value = aws_eip.elasticip.public_ip
}