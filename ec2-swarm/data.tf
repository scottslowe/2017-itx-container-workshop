data "aws_ami" "swarm_ami" {
    most_recent             = true
    filter {
        name                = "name"
        values              = ["*ubuntu-trusty-14.04*"]
    }
    filter {
        name                = "virtualization-type"
        values              = ["hvm"]
    }
    filter {
        name                = "root-device-type"
        values              = ["ebs"]
    }
}
