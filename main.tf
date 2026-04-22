# Configure the AWS provider
provider "aws" {
    region = "us-east-1"
}

# Write
# terraform init
# terraform plan
# terraform apply
# terraform destroy

# VPC
resource "aws_vpc" "main_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "main_vpc"
    }
}

# Subnet 1
resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "subnet1"
    }  
}

# Subnet 2
resource "aws_subnet" "subnet2" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    tags = {
        Name = "subnet2"
    }    
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main_vpc.id
    tags = {
        Name = "igw"
    }  
}

# Route Table
resource "aws_route_table" "route_table" {
    vpc_id = aws_vpc.main_vpc.id
    route = {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
}
    tags = {
        Name = "main_route_table"
    }  
}

# Route Table Association a
 resource "aws_route_table_association" "a" {
    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_route_table.route_table.id
}

# Route Table Association b 
resource "aws_route_table_association" "b" {
    subnet_id = aws_subnet.subnet2.id
    route_table_id = aws_route_table.route_table.id
}
