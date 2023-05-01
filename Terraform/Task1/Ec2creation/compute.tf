resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow http inbound traffic"
  vpc_id      = local.vpc_id
  ingress {
    description = "http"
    from_port   = local.http_port
    to_port     = local.http_port
    protocol    = local.tcp
    cidr_blocks = [local.anywhere]
  }
  ingress {
    description = "ssh"
    from_port   = local.ssh_port
    to_port     = local.ssh_port
    protocol    = local.tcp
    cidr_blocks = [local.anywhere]
  }
  tags = {
    Name = "web-sg"
  }
  depends_on = [
    aws_subnet.ntier_subnets
  ]
}
resource "aws_key_pair" "mykeypair" {
  key_name   = "mkeypair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBar009am9YVG7Z5jc687AbdDCJaOuBaxWl7dYhE27rHRjJirbEcCzAHHHRFi7DOdXHsUjTaK6DIf2GHZbea8tFwprXyw9yG12X+vsAi1CTFDRe6+tJ0avF0l16yqKT5Q0Vck5FwmE9Dt5+30HVvUhP7wM8sqiHpw5G5z3Flc6apMPrXZC6UXoTTszNw055LqnyQoG+fC+edU9J46nb/T8Yd+G9mWaAhXxOML49LkpBlYPSsN7LP6ExdQzRvrKHaFx+X2IChmDFZN6p2qG5Rs1EQosz9h1jZPim3UQTMIIiFpI741i+UjU+v65Z+84QtA2jn8x0tXcYaPLy3729+ZAc9ktPd9SvYQac/Njsoy6/cwaake6LPUL0rn6zZ2pyO7UCBdqZNsy6DcFtObI86v/+Q6wCq909s2UbN49FlbXU8iVc7IU0VE+MtEVfs4VwRxvoYT7h6m1/o6/TrmKbQg++/OQDzVbi5vOuvne/FgYPQHOn6Q6Xf9QKZuNh6Pg4QU= vmsri@LAPTOP-VK6D8MHS-VM"
}
resource "aws_instance" "web" {
  ami                         = var.ami_id
  subnet_id                   = data.aws_subnets.public.ids[0]
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.mykeypair.id
  tags = {
    "Name" = "EC2-instance"
  }
  depends_on = [
    aws_security_group.web_sg
  ]
}
