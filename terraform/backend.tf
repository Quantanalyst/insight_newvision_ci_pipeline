terraform {
  backend "s3" {
    bucket = "newvision_cicd_sm"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}