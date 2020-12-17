resource "aws_s3_bucket" "s3"{
    bucket = var.s3_storage_name

    versioning {
      enabled =  true
    }

    server_side_encryption_configuration {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = "AES256"
        }
      }
    }

    tags = merge(
    var.global_tags,
    {
      "Name" = "AWS Storage"
    },
  )
}