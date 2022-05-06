resource "aws_s3_bucket" "tf-bucket" {
    bucket_prefix = "${var.bucket_prefix}" 
    acl = "${var.acl_value}"
}