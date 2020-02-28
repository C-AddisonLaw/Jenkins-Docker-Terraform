variable "region" {
  default = "us-west-2"
}

variable "shared_credentials_file" {
  default  = "/root/.aws/credentials"
}

variable "ami" {
  default =  "ami-067a8d21baaf68acd"
}

variable "key_path" {
  default = "/root/.ssh/id_rsa.pub"
}

