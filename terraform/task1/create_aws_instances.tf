# current terraform version v1.7.5
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs

#variables
#https://developer.hashicorp.com/terraform/language/values/variables

variable "ami" {
  default = "ami-830c94e3"
  type    = string
}

variable "instance_type" {
  default = "t2.micro"
  type    = string
}

variable "tags" {
  default = "First"
  type    = string
}

# terraform plan -var tags=second


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}
//c
provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["credentials"]
  profile                  = "default"
}

resource "aws_instance" "first_server" {
  #aws machine image 
  #https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = var.tags
  }
}
