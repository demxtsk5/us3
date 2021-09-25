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
  profile = "default"
  region  = var.vpc_region
}
# Aufbau eines virtuelle cloud (virt. RZ)
resource "aws_vpc" "ansible_vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = "Ansible VPC"
  }
}
# Anlegen von Netzwerken
resource "aws_subnet" "ansible_pub1" {
  vpc_id     = aws_vpc.ansible_vpc.id
  cidr_block = "10.0.0.0/25"
  availability_zone = "eu-central-1a"
  tags = {
    Name = "ansible public network"
  }
}
# Erstellen vom Internet Gateway
resource "aws_internet_gateway" "ansible_igw" {
  vpc_id = aws_vpc.ansible_vpc.id
  tags = {
    Name = "ansible igw"
  }
}
# Routingtabelle anlegen und mit IGW verbinden
resource "aws_route_table" "ansible_rtb" {
  vpc_id = aws_vpc.ansible_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ansible_igw.id
  }
  tags = {
    Name = "michas tolle routing tabelle"
  }
}
# public Netzwerk mit Routingtablle verbinden
 resource "aws_route_table_association" "ansible_subnet-connect1" {
  subnet_id = aws_subnet.ansible_pub1.id
  route_table_id = aws_route_table.ansible_rtb.id
}
# Security Group anlegen
# jedes Netzwerkinterface (nic) einer MUSS eine Security group zugewiesen werden -
# funktioniert ähnlich einer FW. Der eingehende Traffic wird gefiltert. Um den ausgehenden Traffic,
# muss sich im OS der VM gekümmert.
resource "aws_security_group" "ansible_seg" {
    description = "Allow incoming SSH access"
    vpc_id = aws_vpc.ansible_vpc.id
    ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks =  ["0.0.0.0/0"]
    }
    ingress {
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks =  ["0.0.0.0/0"]
    }    
    ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks =  ["10.0.0.0/25"]
    }
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name = "ansible ssh access"
    }
}
# Aufbau einer Instanz
resource "aws_instance" "ansible_instanz" {
  ami = "ami-0453cb7b5f2b7fca2"
  count = 2
  instance_type = "t2.micro"
  subnet_id = aws_subnet.ansible_pub1.id
  security_groups = [aws_security_group.ansible_seg.id]
  key_name = "gdcjmcm"
  associate_public_ip_address = true
  tags = {
    Name = "ansible test server"
  }
}
output "IP_Adressen" {
  value = aws_instance.ansible_instanz.*.public_ip
}
output "IP_internal" {
  value = aws_instance.ansible_instanz.*.private_ip
}