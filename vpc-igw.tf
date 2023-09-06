resource "aws_vpc" "vpc" {
    cidr_block               = var.cidr
    instance_tenancy         = "default"
    enable_dns_hostnames     = true
    enable_dns_support       = true

    tags = {
      Name              = "${var.accountname}-vpc-by-Natalia"
      Environment       = "${var.environment}"
      Created_By        = "${var.Created_By}"
      Terraform_Managed = "${var.Terraform_Managed}"
    }
}

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id              = aws_vpc.vpc.id

     tags = {
      Name              = "${var.accountname}-igw"
      Environment       = "${var.environment}"
      Created_By        = "${var.Created_By}"
      Terraform_Managed = "${var.Terraform_Managed}"
    }   
}

#use aws data source to get all avalablitiy zones in the region
data "aws_availability_zones" "available_zones" {}

resource "aws_subnet" "public_subnet1" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.public_subnet1
  availability_zone        = data.aws_availability_zones.available_zones.names [0]
  map_public_ip_on_launch  = true

  tags = {
    Name                  = "${var.accountname}-public_subnet1"
      Environment         = "${var.environment}"
      Created_By          = "${var.Created_By}"
      Terraform_Managed   = "${var.Terraform_Managed}"
    }   
}

resource "aws_subnet" "public_subnet2" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.public_subnet2
  availability_zone        = data.aws_availability_zones.available_zones.names [1]
  map_public_ip_on_launch  = true

  tags = {
    Name                  = "${var.accountname}-public_subnet2"
      Environment         = "${var.environment}"
      Created_By          = "${var.Created_By}"
      Terraform_Managed   = "${var.Terraform_Managed}"
    }   
}

resource "aws_subnet" "private_subnet1" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = var.private_subnet1
    availability_zone       = data.aws_availability_zones.available_zones.names [0]
    map_public_ip_on_launch = false

     tags = {
      Name              = "${var.accountname}-private_subnet1"
      environment       = "${var.environment}"
      Created_By        = "${var.Created_By}"
      Terraform_Managed = "${var.Terraform_Managed}"
    }      
}

resource "aws_subnet" "private_subnet2" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = var.private_subnet2
    availability_zone       = data.aws_availability_zones.available_zones.names [1]
    map_public_ip_on_launch = false

     tags = {
      Name              = "${var.accountname}-private_subnet2"
      environment       = "${var.environment}"
      Created_By        = "${var.Created_By}"
      Terraform_Managed = "${var.Terraform_Managed}"
    }      
}

resource "aws_route_table" "public_route_table" {
    vpc_id                  = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }

     tags = {
      Name              = "public route table"
      environment       = "${var.environment}"
      Created_By        = "${var.Created_By}"
      Terraform_Managed = "${var.Terraform_Managed}"
    }     
}

resource "aws_route_table_association" "public_subnet_az_a_cidrs_association" {
    subnet_id           = aws_subnet.public_subnet1.id
    route_table_id      = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_az_b_cidrs_association" {
    subnet_id           = aws_subnet.public_subnet2.id
    route_table_id      = aws_route_table.public_route_table.id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_attachment" {
    vpc_id                  = aws_vpc.vpc.id
    subnet_ids              = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id ]
    transit_gateway_id      = var.tgw_id 

     tags = {
      Name              = "${var.accountname}-tgw-attachment"
      environment       = "${var.environment}"
      Created_By        = "${var.Created_By}"
      Terraform_Managed = "${var.Terraform_Managed}"
    }   
}

resource "aws_route_table" "internal_route_table" {
    vpc_id                  = aws_vpc.vpc.id

    route {
        cidr_block         = "10.0.0.0/8"
        transit_gateway_id = var.tgw_id
    }

     tags = {
      Name              = "internal route table"
      environment       = "${var.environment}"
      Created_By        = "${var.Created_By}"
      Terraform_Managed = "${var.Terraform_Managed}"
    }     
}

resource "aws_route_table_association" "subnet_az_a_cidrs" {
    subnet_id           = aws_subnet.private_subnet1.id
    route_table_id      = aws_route_table.internal_route_table.id
}

resource "aws_route_table_association" "subnet_az_b_cidrs" {
    subnet_id           = aws_subnet.private_subnet2.id
    route_table_id      = aws_route_table.internal_route_table.id
}

resource "aws_route53_resolver_rule_association" "Route53_ResolverRule_VPC_Association" {
  resolver_rule_id  = var.route53-outboundresolver-rule_id
  vpc_id            = aws_vpc.vpc.id
}
