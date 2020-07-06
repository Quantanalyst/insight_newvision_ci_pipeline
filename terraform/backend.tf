terraform {
  backend "s3" {
    bucket = "newvision_cicd_sm"
    key    = "terraform.tfstate"
    region = "us-west-2"
    # integrate with dynamodb to support state locking
    dynamodb_table = "s3-state-lock"
  }
}