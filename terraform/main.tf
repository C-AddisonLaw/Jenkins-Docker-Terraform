# Provider
provider "aws" {
  region = var.region
  shared_credentials_file = var.shared_credentials_file
}

resource "aws_security_group_rule" "allow_8080" {
  type            = "ingress"
  from_port       = 8080
  to_port         = 8080
  protocol        = "tcp"
  cidr_blocks     = ["0.0.0.0/0"]
  security_group_id = "sg-4be4a238"
}

# Define SSH key pair for our instances
resource "aws_key_pair" "default" {
  key_name = "jenkins"
  public_key = file(var.key_path)
}

# Define server1
resource "aws_instance" "Jenkins" {
  ami = var.ami
  instance_type = "t3.micro"
  key_name = aws_key_pair.default.id

  user_data = file("bootstrap.sh")

  tags = {
    Name = "Jenkins"
  }
}

