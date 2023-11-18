variable "ec2name" {
    type = string
}

variable "securitygroups" {
    type = list(string)
}

variable "userdata" {
    type = string
    default = null
}

variable "condition" {
    type = bool
    default = false
}

resource "aws_instance" "ec2" {
    ami = "ami-06018068a18569ff2"
    instance_type = "t2.micro"
    security_groups = var.securitygroups
    tags = {
        Name = var.ec2name
    }
    user_data = var.condition ? file(var.userdata) : null
}

output "instance_id" {
    value = aws_instance.ec2.id
}

