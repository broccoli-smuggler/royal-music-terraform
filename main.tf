provider "aws" {
  profile = var.profile
  region = "us-east-1"
}

module "royalmusictour_website" {
  source         = "git::https://github.com/cloudposse/terraform-aws-s3-website.git?ref=master"
  namespace      = var.profile 
  stage          = var.stage
  name           = var.app
  hostname       = var.domain_name
  force_destroy  = true
}

module "royalmusictour_website_www" {
  source         = "git::https://github.com/cloudposse/terraform-aws-s3-website.git?ref=master"
  namespace      = var.profile
  stage          = var.stage
  name           = var.app
  hostname       = join(".", ["www", var.domain_name])
  redirect_all_requests_to = var.domain_name
  force_destroy  = true
}

provider "archive" {}

data "archive_file" "init" {
  type        = "zip"
  source_dir = var.artifact_dir
  output_path = "site.zip"
}

resource "null_resource" "upload_web_resouce" {
  triggers = {
    src_hash = data.archive_file.init.output_sha
  }

  provisioner  "local-exec" {
    command = "aws s3 sync ${var.artifact_dir} s3://${module.royalmusictour_website.s3_bucket_name} --profile ${var.profile} --delete"
  }
  depends_on = [module.royalmusictour_website]
}

