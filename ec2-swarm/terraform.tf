terraform {
    backend "s3" {
        bucket  = "itx2017demo"
        key     = "ec2-swarm/terraform.tfstate"
        region  = "us-west-2"
        encrypt = true
    }
}
