# Create a security group to allow Swarm and web traffic
resource "aws_security_group" "swarm_sg" {
    vpc_id                  = "${aws_vpc.ec2_swarm_vpc.id}"
    name                    = "swarm-sg"
    description             = "Security group for Swarm traffic"
    ingress {
        from_port           = "0"
        to_port             = "0"
        protocol            = "-1"
        cidr_blocks         = ["${aws_vpc.ec2_swarm_vpc.cidr_block}"]
    }
    ingress {
        from_port           = "22"
        to_port             = "22"
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"]
    }
    ingress {
        from_port           = "8888"
        to_port             = "8888"
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"]
    }
    ingress {
        from_port           = "8080"
        to_port             = "8080"
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"]
    }
    egress {
        from_port           = "0"
        to_port             = "0"
        protocol            = "-1"
        cidr_blocks         = ["0.0.0.0/0"]
    }
    tags {
        tool                = "terraform"
        demo                = "ec2-swarm"
        area                = "security"
    }
}
