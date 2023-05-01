module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"
  providers = {
    aws = aws.hyderabad
  }
  tags = {
    Name = "drum"
  }
}

module "vpc_1" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"
  providers = {
    aws = aws.mumbai
  }
  tags = {
    Name = "Santa"
  }
}
