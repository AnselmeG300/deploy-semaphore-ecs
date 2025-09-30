resource "aws_s3_bucket" "semaphore_alb_bucket" {
  bucket = "bucket-semaphore-alb"

  tags = {
    Name        = "bucket-semaphore-alb"
    Environment = "Prod"
  }
}

resource "aws_s3_bucket_policy" "semaphore_alb_bucket_policy" {
  bucket = aws_s3_bucket.semaphore_alb_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "elasticloadbalancing.amazonaws.com"
        },
        Action = "s3:*",
        Resource = "${aws_s3_bucket.semaphore_alb_bucket.arn}/*"
      }
    ]
  })
}


