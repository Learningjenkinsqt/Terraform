resource "aws_vpc" "prakash" {
  cidr_block = var.prakash_vpc_info.vpc_cidr
  tags = {
    Name = "prakash"
  }

}

resource "aws_subnet" "subnets" {
  count             = length(var.prakash_vpc_info.subnet_names)
  cidr_block        = cidrsubnet(var.prakash_vpc_info.vpc_cidr, 8, count.index)
  availability_zone = "${var.region}${var.prakash_vpc_info.subnet_azs[count.index]}"
  vpc_id            = aws_vpc.prakash.id #implicit dependency
  depends_on = [
    aws_vpc.prakash
  ]
  tags = {
    Name = var.prakash_vpc_info.subnet_names[count.index]
  }

}