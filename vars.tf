variable "vpc_region" {
    default = "eu-central-1"
    description = "in dieser Region wird die VPC erstellt"
}
variable "cidr_block" {
  default = "10.0.0.0/23"
  description = "Hauptnetz in der VPC"
}