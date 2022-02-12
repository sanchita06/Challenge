terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.0.0"
    }
  }
}

provider "aws" {
  # Configuration options
    region     = var.region
}