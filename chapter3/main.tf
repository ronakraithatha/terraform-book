provider "aws" {
  region = "us-east-1"
}

#* S3 stores the state file in a way that is
#* both shared and accessible by all users
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-elden-ring-is-amazing"

  #* Prevent accidental deletion of this S3 bucket
  #? How much does this prevent it? Will t destroy with yes still delete it?
  #* Yes, this will cause t destroy to error out.
  #* Work around here is to comment the line
  lifecycle {
    prevent_destroy = true
  }
}

#* Enable versioning so we can see the full revision history
#* of our state files
resource "aws_s3_bucket_versioning" "terraform-state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}


#* Enable server-side encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform-state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

#* DynamoDB table to handle locking to the state file
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-uar-state"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
