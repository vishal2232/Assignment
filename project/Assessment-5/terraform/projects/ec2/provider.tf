provider "aws" {
 assume_role {
   role_arn = "<Admin Role ARN>"
 }
 region = "us-east-1"
}

terraform {
 backend "s3" {
   bucket   = ""
   key      = ""
   region   = "us-east-1"
   role_arn = "<S3 Bucket ARN>"
 }
}
