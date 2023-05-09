resource "aws_instance" "nginx" {
  ami           = "ami-c58c1dd3"
  instance_type = "${var.instance_type}"
  key_name        = "${var.key_name}"

  connection {
    user        = "ec2-user"
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install nginx -y",
      "sudo service nginx start"
    ]
  }
}