locals {
  vpc_cidr  = var.ntier_vpc_info.vpc_cidr
  vpc_id    = aws_vpc.ntier_vpc.id
  anywhere  = "0.0.0.0/0"
  tcp       = "tcp"
  ssh_port  = 22
  http_port = 80
}
