terraform {
    backend "s3" {
        bucket  = "BUCKETNAME" #Specify name of an existing bucket for terraform state to be stored
        key     = "ec2-swarm/terraform.tfstate" #Name of terraform state file
        region  = "REGION OF BUCKET" #Region where the bucket is located
        encrypt = true
    }
}
