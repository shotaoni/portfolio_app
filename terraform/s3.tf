resource "aws_s3_bucket" "tante-s3-bucket" {
  bucket        = "tante-s3-bucket"
  force_destroy = true
  acl           = "public-read"

  cors_rule {
    allowed_origins = ["*"]
    allowed_methods = ["GET"]
    allowed_headers = ["*"]
  }

  tags = {
    Name = "tante-s3-bucket"
  }
}
resource "aws_s3_bucket_public_access_block" "private" {
  bucket                  = aws_s3_bucket.tante-s3-bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "artifact" {
  bucket = "artifact-pragmatic-terraform-for-tante"

  lifecycle_rule {
    enabled = true

    expiration {
      days = "180"
    }
  }
}