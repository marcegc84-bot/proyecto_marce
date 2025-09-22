resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virginia_cidr
  tags = {
    "Name" = "vpc_virginia-${local.sufix}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_virginia.id
  cidr_block              = var.subnet[0]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "public_subnet-${local.sufix}"
  }

}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_virginia.id
  cidr_block = var.subnet[1]
  tags = {
    "Name" = "private_subnet-${local.sufix}"
  }

  depends_on = [
    aws_subnet.public_subnet
  ]

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_virginia.id

  tags = {
    Name = "IGW vpc virginia-${local.sufix}"
  }
}

resource "aws_route_table" "public_crt" { #para que puedas salir a internet #public_crt (public custom route table)
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_crt-${local.sufix}"
  }
}

resource "aws_route_table_association" "crta_public_subnet" { #crta custom route table asociate
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}

resource "aws_security_group" "sg_public_instance_ingress" {
  name        = "Public Instance-${local.sufix}"
  description = "Allow SSH inbound traffic and all egress traffic"
  vpc_id      = aws_vpc.vpc_virginia.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.sg_ingress_cidr] #declaramos esta variable para pasarle la ip

  }

  egress { #La salida la dejamos como esta, porque vamos a permitir todo el trafico de salida
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "Public instance-${local.sufix}"
  }
  #Por ultimo tenemos que asociar el security group a nuestra instancia

}