terraform {
	backend "s3" {
		bucket = "terraform-bucket-for-state-today"
		key = "prod/terraform.tfstate"
		region = "us-east-1"
	}
}