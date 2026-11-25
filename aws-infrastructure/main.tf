
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# Discover available Availability Zones

data "aws_availability_zones" "available" {
  state = "available"
}

# Create VPC

resource "aws_vpc" "databricks_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-vpc"
  })
}

# Internet Gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.databricks_vpc.id

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-igw"
  })
}

# Public subnet definitions

locals {
  public_subnets = {
    public-a = {
      cidr     = "10.20.1.0/24"
      az_index = 0
    }
    public-b = {
      cidr     = "10.20.2.0/24"
      az_index = 1
    }
  }

  private_subnets = {
    private-a = {
      cidr     = "10.20.11.0/24"
      az_index = 0
    }
    private-b = {
      cidr     = "10.20.12.0/24"
      az_index = 1
    }
  }
}

# Public subnets

resource "aws_subnet" "public" {
  for_each = local.public_subnets

  vpc_id                  = aws_vpc.databricks_vpc.id
  cidr_block              = each.value.cidr
  availability_zone       = data.aws_availability_zones.available.names[each.value.az_index]
  map_public_ip_on_launch = true

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-${each.key}"
    Tier = "Public"
  })
}

# Private subnets

resource "aws_subnet" "private" {
  for_each = local.private_subnets

  vpc_id            = aws_vpc.databricks_vpc.id
  cidr_block        = each.value.cidr
  availability_zone = data.aws_availability_zones.available.names[each.value.az_index]

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-${each.key}"
    Tier = "Private"
  })
}

# Public route table

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.databricks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-public-rt"
  })
}

# Associate public subnets

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# Private route table
# No internet route yet. NAT Gateway will be considered later.

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.databricks_vpc.id

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-private-rt"
  })
}

# Associate private subnets

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}


module "s3" {
  source = "../modules/s3"

  bucket_prefix = "databricks-admin-lab-"

  tags = {
    Project     = "Future-Unicorn"
    Environment = "Dev"
    ManagedBy   = "Terraform"
  }
}
