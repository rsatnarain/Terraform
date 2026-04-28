# Author: Rob
# Created: 2026-04-27
# Description: This file configures the AWS provider for Terraform, specifying the region to use for AWS resources. The provider block is essential for Terraform to interact with AWS services and manage infrastructure as code. In this case, the region is set to "us-east-1", which is a common AWS region located in North Virginia. This configuration allows Terraform to create and manage resources in that specific region when executing Terraform commands.
#
# Updated By    Updated On    Description
# -----------  ------------  ------------------------------------------------
# Rob          2026-04-27    Initial creation of the AWS provider configuration.

provider "aws" {
    region = "us-east-1"
  
}

# VPC
resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "main-tf-vpc"
  
    }
}

# Subnet 1
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Subnet1"
  
    }
}

# Subnet 2
resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "Subnet2"
  
    }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-vpc-igw"
  
    }
}

# Route Table
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

  }
  tags = {
    Name = "main-route-table"
  
  }
}

# Associate Route Table with Subnet 1
resource "aws_route_table_association" "subnet1_association" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route_table.id
}

# Associate Route Table with Subnet 2
resource "aws_route_table_association" "subnet2_association" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.route_table.id
}

