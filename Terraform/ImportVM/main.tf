resource "aws_vpc" "my_vpc" {

}

resource "aws_instance" "test1" {
  ami = "ami-02eb7a4783e7e9317"
  instance_type = "t2.nano"
  tags = {
    Name = "lucky"
  }
}

resource "aws_instance" "test2" {
  ami = "ami-02eb7a4783e7e9317"
  instance_type = "t2.nano"
  tags = {
    Name = "fat"
  }
}

resource "aws_lb" "myload-balancer" {
  
}
