resource "aws_vpc" "prakash" {
  count = length(var.prakash_vpc_info.vpc_cidr)
  cidr_block = var.prakash_vpc_info.vpc_cidr[count.index]
  tags = {
    Name = "prakash"
  }

}

resource "aws_subnet" "subnets" {
  count             = length(var.prakash_vpc_info.subnet_names)
  cidr_block        = cidrsubnet(var.prakash_vpc_info.vpc_cidr[count.index%2], 8, count.index)
  availability_zone = "${var.region}${var.prakash_vpc_info.subnet_azs[count.index]}"
  vpc_id            =  aws_vpc.prakash[count.index%2].id
  depends_on = [
    aws_vpc.prakash
  ]
  tags = {
    Name = var.prakash_vpc_info.subnet_names[count.index]
  }

}
