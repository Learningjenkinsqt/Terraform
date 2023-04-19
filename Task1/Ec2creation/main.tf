resource "aws_vpc" "ntier_vpc" {
  cidr_block = local.vpc_cidr
  tags = {
    "Name" = "ntier_vpc"
  }
}
resource "aws_subnet" "ntier_subnets" {
  vpc_id            = local.vpc_id
  availability_zone = "${var.region}${var.ntier_vpc_info.subnet_azs[0]}"
  cidr_block        = cidrsubnet(local.vpc_cidr, 8, 1)
  tags = {
    "Name" = var.ntier_vpc_info.web_ec2_subnet
  }
  depends_on = [
    aws_vpc.ntier_vpc
  ]
}
resource "aws_internet_gateway" "ntier_igw" {
  vpc_id = local.vpc_id
  tags = {
    "Name" = "ntier_igw"
  }
  depends_on = [
    aws_vpc.ntier_vpc
  ]
}
resource "aws_route_table" "public_rt" {
  vpc_id = local.vpc_id
  route {
    cidr_block = local.anywhere
    gateway_id = aws_internet_gateway.ntier_igw.id
  }
  tags = {
    "Name" = "public_rt"
  }
  depends_on = [
    aws_internet_gateway.ntier_igw,
    aws_subnet.ntier_subnets
  ]
}
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }
  filter {
    name   = "tag:Name"
    values = [var.ntier_vpc_info.web_ec2_subnet]
  }
  depends_on = [
    aws_subnet.ntier_subnets
  ]
}
resource "aws_route_table_association" "public_rt_associations" {
  subnet_id      = data.aws_subnets.public.ids[0]
  route_table_id = aws_route_table.public_rt.id
}
