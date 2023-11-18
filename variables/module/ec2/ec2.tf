

resource "aws_instance" "ec2" {
    # count = 3
    ami = "ami-06018068a18569ff2"
    instance_type = "t2.micro"
  
}