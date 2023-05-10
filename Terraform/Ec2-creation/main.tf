resource "aws_instance" "firstinstence" {
  for_each                    = toset(["one", "two"])
  ami                         = "ami-02eb7a4783e7e9317"
  instance_type               = "t2.micro"
  key_name                    = "id_rsa"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["sg-0968c4e2044456b8f"]
  subnet_id                   = data.aws_subnet.first.id

  tags = {
    Name = "firstinstence"  
  }

}
