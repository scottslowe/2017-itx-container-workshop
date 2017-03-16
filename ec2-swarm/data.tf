data "aws_ami" "coreos_ami" {
    filter {
        name                = "name"
        values              = ["*CoreOS-stable-1298.6.0*"]
    }
    filter {
        name                = "virtualization-type"
        values              = ["hvm"]
    }
}
