#Create the S3 bucket

resource "aws_s3_bucket" "bucket1" {
  bucket = "web-bucket-vishal-yadav"

}

#Allow public Access Settings

resource "aws_s3_bucket_public_access_block" "bucket1" {
  bucket = aws_s3_bucket.bucket1.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

#Upload index.html

resource "aws_s3_object" "index" {
  bucket       = "web-bucket-vishal-yadav"
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"
}


#Upload err.html file

resource "aws_s3_object" "error" {
  bucket       = "web-bucket-vishal-yadav"
  key          = "error.html"
  source       = "error.html"
  content_type = "text/html"
}

#Configure S3 Website Hosting

resource "aws_s3_bucket_website_configuration" "bucket1" {
  bucket = aws_s3_bucket.bucket1.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}


#Make the Website Public (Bucket Policy)

resource "aws_s3_bucket_policy" "public_read_access" {
  bucket = aws_s3_bucket.bucket1.id
  policy = <<EOF
  {
    "Version" : "2012-10-17",
    "Statement": [
    {
        "Effect": "Allow",
        "Principal": "*",
        "Action": [ "s3:GetObject"],
        "Resource": [
            "${aws_s3_bucket.bucket1.arn}",
            "${aws_s3_bucket.bucket1.arn}/*"
        ]   
    }
    ]
  }
EOF  
}