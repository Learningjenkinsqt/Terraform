terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.62.0"

    }
  }
}

provider "aws" {
  region = "ap-south-2"
  alias  = "hyderabad"
}

provider "aws" {
  region = "ap-south-1"
  alias  = "mumbai"
}
