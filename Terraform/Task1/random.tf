resource "random_password" "rdspassword" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "aws_db_instance" "myrds" {
  instance_class            = "db.t2.micro"
  allocated_storage         = 20
  engine                    = "mysql"
  username                  = "dbadmin"
  password                  = "dbadmin#02prakash"
  final_snapshot_identifier = "myrds-backup"
  skip_final_snapshot       = true
}