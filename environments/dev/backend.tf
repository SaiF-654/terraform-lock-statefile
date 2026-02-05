#env/dev/ in key is just a logical path inside the S3 bucket, it doesn’t need to match your local folder names.

terraform {
  backend "s3" {
    bucket         = "saif-terraform-state-bucket-111"
    key            = "env/dev/terraform.tfstate"     
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}
