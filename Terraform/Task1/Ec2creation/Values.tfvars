variable "region" {
  type    = string
  default = "ap-south-1"
}
variable "ami_id" {
  type    = string
  default = "ami-02eb7a4783e7e9317"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "ntier_vpc_info" {
  type = object({
    vpc_cidr       = string
    subnet_azs     = list(string)
    web_ec2_subnet = string
  })
  default = {
    vpc_cidr       = "192.168.0.0/16"
    subnet_azs     = ["a", "b"]
    web_ec2_subnet = "web1"
  }
}
