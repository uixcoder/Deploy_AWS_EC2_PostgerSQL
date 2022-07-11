resource "aws_instance" "DB_PetClinic_TF" {
  ami                    = "ami-06a2a41d455060f8b"
  instance_type          = "t3.micro"
  key_name               = "ATC"
  vpc_security_group_ids = [aws_security_group.sg_db.id]
  credit_specification {
    cpu_credits = "standard"
  }
  tags = {
    Name    = "DB_TF"
    Owner   = "idanylyuk"
    Project = "Petclinic"
  }
}

resource "aws_security_group" "sg_db" {
  name = "sg_db_pet"
  ingress {
    from_port   = "9100"
    to_port     = "9100"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }   
  ingress {
    from_port   = "5432"
    to_port     = "5432"
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.App_PetClinic_TF.public_ip}/32"]
  }
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "DB_TF"
  }
}

resource "aws_route53_record" "dbpet1" {
  zone_id = "Z0118956EU069IAZHTCP"
  name    = "db1.xcoder.pp.ua"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.DB_PetClinic_TF.public_ip]
}
