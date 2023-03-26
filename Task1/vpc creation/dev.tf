# # Define the VPCs
# resource "aws_vpc" "prakash_vpc" {
#   count         = 2
#   cidr_block    = "10.0.${count.index}.0/16"
#   instance_tenancy = "default"

#   tags = {
#     Name = "prakash-vpc-${count.index}"
#   }
# }

# # Define the subnets
# resource "aws_subnet" "prakash_subnet" {
#   count = 12
#   vpc_id = aws_vpc.prakash_vpc.[count.index%2].id
#   cidr_block = "10.0.${count.index/6}.${count.index%6}/24"
  
#   tags = {
#     Name = "prakash-subnet-${count.index}"
#   }
# }