

variable "ports" {
  type = list(number)
}

variable "cidr_blocks" {
    type = list(string)
}


resource "aws_security_group" "webtraffic" {
    name = "Allow HTTP HTTPS"
    description = "allows http and https traffic"

    dynamic "ingress" {
        for_each = toset(var.ports)
        content {
            from_port = ingress.value
            to_port  = ingress.value
            protocol = "tcp"
            cidr_blocks = var.cidr_blocks
        }
    }

    dynamic "egress" {
        for_each = toset(var.ports)
        content {
            from_port = egress.value
            to_port  = egress.value
            protocol = "tcp"
            cidr_blocks = var.cidr_blocks
        }
    }
}

output "name" {
    value = aws_security_group.webtraffic.name
}