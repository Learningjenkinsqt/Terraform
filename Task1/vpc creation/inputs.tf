variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "Region to create resources"
}

variable "prakash_vpc_info" {
  type = object({
    vpc_cidr     = list(string),
    subnet_azs   = list(string),
    subnet_names = list(string)
  })
  default = {
    subnet_azs   = ["a", "b", "a", "b", "a", "b"]
    subnet_names = ["sub1", "sub2", "sub3", "sub4", "sub5", "sub6",]
    vpc_cidr     = ["192.168.0.0/16", "10.0.0.0/16"]
  }

}
