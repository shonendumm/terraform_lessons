# provide resources in order

provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "db" {
  ami = "ami-06018068a18569ff2"
  instance_type = "t2.micro"

  tags = {
    Name = "soohian-ec2"
  }

}

resource "aws_instance" "web" {
  ami = "ami-06018068a18569ff2"
  instance_type = "t2.micro"

  tags = {
    Name = "soohian-ec2"
  }
  depends_on = [ aws_instance.db ]

}


resource "aws_eip" "elasticip" {
  instance = aws_instance.web.id
}

output "public_ip" {
    value = aws_eip.elasticip.public_ip
}

