variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "Region to create resources"
}

variable "prakash_vpc_info" {
  type = object({
    vpc_cidr     = string,
    subnet_azs   = list(string),
    subnet_names = list(string)
  })
  default = {
    subnet_azs   = ["a", "b", "a", "b", "a", "b"]
    subnet_names = ["app1", "app2", "app3", "db1", "db2", "db3"]
    vpc_cidr     = "192.168.0.0/16"
  }

}
