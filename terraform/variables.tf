variable "region" {
  default = "us-west-2"
}

variable "shared_credentials_file" {
  default  = "/root/.aws/credentials"
}

variable "ami" {
  default =  "ami-0b4adf7fa592c5237"
}

variable "key_path" {
  default = "/root/.ssh/id_rsa.pub"
}

