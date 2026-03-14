provider "aws" {
region = "us-east-1"
}

variable "group" {
description = "Specify the group (prod or dev)"
type = string
default = "dev"
}

variable "instance_types" {
type = map(string)
default = {
dev = "t3.micro"
prod = "t3.small"
}
}

resource "aws_instance" "on_demand_instance" {
ami = "ami-000ec6c25978d5999"
instance_type = lookup(var.instance_types, var.group, "t2.micro")
count = var.group == "dev" || var.group == "prod" ? 1:0
tags = {
Name = "Instance-for-${var.group}"
Group = var.group
}
}
