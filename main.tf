provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami = "ami-0538ad7831ddad23d"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-example"
  }
}