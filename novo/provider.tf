terraform {
  required_version = "0.15.4"


  required_providers {

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "2.21.0"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "3.44.0"
    }
  }

}

provider "aws" {
region                  = "sa-east-1"
shared_credentials_file = "/var/lib/jenkins/.aws/credentials"
profile                 = "default"
}

provider "cloudflare" {

  email      = "email"
  api_key    = "XXXXXXXX"
  account_id = "XXXXXXXX"
}
