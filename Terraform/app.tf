resource "aws_instance" "App_PetClinic_TF" {
  ami                    = "ami-0bf2ce41790745811"
  instance_type          = "t3.micro"
  key_name               = "ATC"
  vpc_security_group_ids = [aws_security_group.sg_app.id]
  credit_specification {
    cpu_credits = "standard"
  }
  tags = {
    Name    = "App_TF"
    Owner   = "idanylyuk"
    Project = "Petclinic"
  }
}

resource "aws_security_group" "sg_app" {
  name = "sg_app_pet"
  ingress {
    from_port   = "9100"
    to_port     = "9100"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }  
  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
    Name = "App_TF"
  }
}

resource "aws_route53_record" "pet" {
  zone_id = "Z0118956EU069IAZHTCP"
  name    = "pet1.xcoder.pp.ua"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.App_PetClinic_TF.public_ip]
}
