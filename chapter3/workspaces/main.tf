provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-state-elden-ring-is-amazing"
    key    = "workspaces-example/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}

resource "aws_instance" "example" {
  ami           = "ami-0538ad7831ddad23d"
  instance_type = "t2.micro"
}
