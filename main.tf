terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"
}

# Provider und Region festlegen
provider "aws" {
  profile = "mg0050"
  region  = var.vpc_region
}
# Aufbau eines virtuelle cloud (virt. RZ)
resource "aws_vpc" "micha" {
  cidr_block = var.cidr_block
  tags = {
    Name = "michas tolle VPC"
  }
}
# Anlegen von Netzwerken
resource "aws_subnet" "pub1" {
  vpc_id     = aws_vpc.micha.id
  cidr_block = "10.0.0.0/25"
  availability_zone = "eu-central-1a"
  tags = {
    Name = "public network"
  }
}
resource "aws_subnet" "pri1" {
  vpc_id     = aws_vpc.micha.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-central-1a"
  tags = {
    Name = "private network"
  }
}  
# Erstellen vom Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.micha.id
  tags = {
    Name = "michas igw"
  }
}
# Routingtabelle anlegen und mit IGW verbinden
resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.micha.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "michas tolle routing tabelle"
  }
}
# public Netzwerk mit Routingtablle verbinden
 resource "aws_route_table_association" "subnet-connect1" {
  subnet_id = aws_subnet.pub1.id
  route_table_id = aws_route_table.rtb.id
}
# Security Group anlegen
# jedes Netzwerkinterface (nic) einer MUSS eine Security group zugewiesen werden -
# funktioniert ähnlich einer FW. Der eingehende Traffic wird gefiltert. Um den ausgehenden Traffic,
# muss sich im OS der VM gekümmert.
resource "aws_security_group" "seg" {
    description = "Allow incoming SSH access"
    vpc_id = aws_vpc.micha.id
    ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks =  ["0.0.0.0/0"]
    }
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name = "micha ssh access"
    }
}
# Aufbau einer Instanz
resource "aws_instance" "webserver1" {
  ami = "ami-0453cb7b5f2b7fca2"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.pub1.id
  security_groups = [aws_security_group.seg.id]
  key_name = "michas_toller_key"
  associate_public_ip_address = true
  tags = {
    Name = "michas toller webserver"
  }
}