data "aws_ami" "swarm_ami" {
    most_recent             = true
    filter {
        name                = "name"
        values              = ["*CentOS Atomic*"]
    }
    filter {
        name                = "virtualization-type"
        values              = ["hvm"]
    }
}
