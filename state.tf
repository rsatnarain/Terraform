terraform {
  backend "s3" {
    bucket = "my-terraform-state-rs13"
    key = "global/s3/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "s3-tf-table"
  }
}

# better collaboration and state management with remote state
# secure state storage in S3 with locking using DynamoDB
# state lock to prevent concurrent modifications
# recovery options with versioning enabled in S3
