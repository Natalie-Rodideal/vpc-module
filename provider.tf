# Terraform Block
terraform {
  required_version = "~> 1.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

# Provider Block
provider "aws" {
  region              = var.region
  profile             = var.accountname #folder name
  allowed_account_ids = [""]
  //   assume_role {
  //     role_arn = "arn:aws:iam::ACCOUNTNUMBER:role/terraform-cross-account-role"
  //   }
}


terraform {
  backend "s3" {
    bucket = "BUCKETNAME"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-1"
  }
}
