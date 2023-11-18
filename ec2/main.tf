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

output "ec2_public_ip" {
    value = aws_instance.ec2.public_ip
}
