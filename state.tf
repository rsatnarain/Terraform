# Author: Rob
# Created: 2026-04-27
# Description: This file configures the Terraform backend to use Amazon S3 for storing the state file and DynamoDB for state locking.
# 

terraform {
  backend "s3" {
    bucket = "my-terraform-state-rs13"
    key = "global/sr/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "s3-tf-table"
        
  }
}