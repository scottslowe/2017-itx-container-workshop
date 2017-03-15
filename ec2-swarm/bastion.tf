# Launch a CentOS 7 instance to serve as bastion host
resource "aws_instance" "bastion" {
    ami                     = "${data.aws_ami.centos_ami.id}"
    instance_type           = "${var.flavor}"
    key_name                = "${var.keypair}"
    vpc_security_group_ids  = ["${aws_security_group.bastion_sg.id}"]
    subnet_id               = "${aws_subnet.ec2_swarm_public.id}"
    depends_on              = ["aws_internet_gateway.ec2_swarm_gw"]
    tags {
        tool                = "terraform"
        demo                = "ec2-swarm"
        area                = "instances"
    }
}
