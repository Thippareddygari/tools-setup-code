resource "aws_instance" "tool" {
  ami = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.tool.id]

  tags = {
    Name= var.name
  }
}

resource "aws_route53_record" "private" {
  zone_id = var.zone_id
  type = "A"
  ttl = 0
  name = "${var.name}-internal"
  records = [aws_instance.tool.private_ip]
}

resource "aws_route53_record" "public" {
  zone_id = var.zone_id
  type = "A"
  name = var.name
  records = [aws_instance.tool.public_ip]
  ttl = 0
}

resource "aws_security_group" "tool" {
  name = "${var.name}-sg"
  description = "${var.name} security group"

  tags = {
    Name = "${var.name}-sg"
  }

}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.tool.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port = 22
  to_port = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_vault_port" {
  security_group_id = aws_security_group.tool.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port = var.port
  to_port = var.port

}