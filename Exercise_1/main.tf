# TODO: Designate a cloud provider, region, and credentials

variable "region" {
  description = "aws region"
  default = "us-east-1"
}
variable "vpc_id" {
  description = "vpc id"
  default = "vpc-4587803f"
}

variable "subnet_public" {
  description = "public subnet"
  default = "subnet-faa812b7"
}

provider "aws" {
  region  = "${var.region}"
  profile = "default"
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "udacity_t2" {
   count = "4"
   instance_type = "t2.micro"
   ami = "ami-0742b4e673072066f"
   subnet_id = "${var.subnet_public}"
   tags = {
       Name = "Udacity T2"
   }
}

