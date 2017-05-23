terraform {
    backend "s3" {
        bucket  = "BUCKET" # Specify name of an existing bucket for terraform state to be stored
        key     = "PATH/terraform.tfstate" # Name and path of terraform state file
        region  = "us-west-2" # Region where the bucket is located
        encrypt = true
    }
}
