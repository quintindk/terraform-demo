

provider "aws" {
  region  = var.aws_region
}

# terraform {
#   backend "s3" {
#     bucket         = "demo-provision"
#     key            = "dev/terraform_aws.tfstate"
#     region         = "us-east-2"
#     dynamodb_table = "demo-tflocks"
#     encrypt = true
#   }
# }