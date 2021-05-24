terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.42.0"
    }
  }
}

provider "aws" {
  region = "sa-east-1"
  shared_credentials_file = "aws/credentials"
  profile = "default"
}

resource "aws_instance" "ec2-instance" {
  ami                         = "YOUR-AMI"
  key_name                    = "YOUR-KEY"
  subnet_id                   = "YOUR-SUBNET"
  instance_type               = "YOUR-INSTANCE-TYPE"
  associate_public_ip_address = "true" ### TRUE Elastic IP -- Public IP

  tags = {
      Name  = "NAME-INSTANCE" ### Appear in web console ec2 dashboard
    }

  root_block_device {
    delete_on_termination = true
  }

  vpc_security_group_ids = ["YOUR-SEC-GROUP"]
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.ec2-instance.id
  allocation_id = aws_eip.eip_assoc.id
}


resource "aws_eip" "eip_assoc" {
  vpc = true

  tags = {
      Name  = "NAME-EIP" ### Appear in web console Elastic IP dashboard 
    }

   depends_on = [aws_instance.ec2-instance]
}

terraform {
  backend "consul" {
    address  = "IP-CONSUL:8500"
    scheme   = "http"
    path     = "tf/NAME-terraform.tfstate"
    lock     = true
    gzip     = false
  }
}
