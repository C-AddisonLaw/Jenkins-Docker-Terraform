# Provider
provider "aws" {
  region = var.region
  shared_credentials_file = var.shared_credentials_file
}

## Get the latest jenkins docker AMI created by packer
data "aws_ami" "latest-jenkins" {
most_recent = true
owners = ["self"]

  filter {
      name   = "name"
      values = ["Jenkins-Docker-*"]
  }
}

## Instance Sec Grp to allow 8080 and ssh
resource "aws_security_group" "instancesg"{
  name = "instance_sec_grp"
  description = "Allow traffic from public subnet"

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

## Define SSH key pair for our instances
resource "aws_key_pair" "default" {
  key_name = "jenkins"
  public_key = file(var.key_path)
}

## Define Jenkins server
resource "aws_instance" "Jenkins" {
  ami = data.aws_ami.latest-jenkins.id
  instance_type = "t3.micro"
  key_name = aws_key_pair.default.id
  #security_groups = [aws_security_group.instancesg.id]
  vpc_security_group_ids = [aws_security_group.instancesg.id]

  user_data = file("bootstrap.sh")

  tags = {
    Name = "Jenkins"
  }
}

