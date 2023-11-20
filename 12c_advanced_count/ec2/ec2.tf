
variable "server_names" {
    type = list(string)
}

resource "aws_instance" "ec2" {
    ami = "ami-06018068a18569ff2"
    instance_type = "t2.micro"
    count = length(var.server_names)
    tags = {
        Name = var.server_names[count.index]
    }

}

output "privateIP" {
    value = aws_instance.ec2.*.private_ip
}