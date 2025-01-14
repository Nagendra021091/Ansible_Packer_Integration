provider "aws" {
  region = var.aws_region
}

data "aws_ami" "gold_image" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["gold-image-*"]
  }
}
