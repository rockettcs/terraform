resource "aws_db_instance" "demodb"{
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  db_subnet_group_name = "main"
  instance_class       = "db.t3.micro"
  identifier           = "demo"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  publicly_accessible = true
  port = 3306

  skip_final_snapshot  = true
}
