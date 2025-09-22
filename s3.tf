resource "aws_s3_bucket" "marce_bucket" {
    #bucket = "BucketPRUEBA"
    bucket = lower(local.s3-sufix)
  
}