terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # stable version, instead of 6.x
    }
  }
}

provider "aws" {
  region = "us-east-1"
}