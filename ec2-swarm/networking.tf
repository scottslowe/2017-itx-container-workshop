# Create a new VPC
resource "aws_vpc" "ec2_swarm_vpc" {
    cidr_block              = "10.1.0.0/16"
    enable_dns_hostnames    = "true"
    enable_dns_support      = "true"
    tags {
        tool                = "terraform"
        demo                = "ec2-swarm"
        area                = "networking"
    }
}

# Create a public subnet in the new VPC
resource "aws_subnet" "ec2_swarm_public" {
    vpc_id                  = "${aws_vpc.ec2_swarm_vpc.id}"
    cidr_block              = "10.1.1.0/24"
    map_public_ip_on_launch = "true"
    tags {
        tool                = "terraform"
        demo                = "ec2-swarm"
        area                = "networking"
    }
}

# Create a new Internet gateway
resource "aws_internet_gateway" "ec2_swarm_gw" {
    vpc_id                  = "${aws_vpc.ec2_swarm_vpc.id}"
    tags {
        tool                = "terraform"
        demo                = "ec2-swarm"
        area                = "networking"
    }
}

# Create a route table for the new VPC
resource "aws_route_table" "ec2_swarm_routes" {
    vpc_id                  = "${aws_vpc.ec2_swarm_vpc.id}"
    route {
        cidr_block          = "0.0.0.0/0"
        gateway_id          = "${aws_internet_gateway.ec2_swarm_gw.id}"
    }
    tags {
        tool                = "terraform"
        demo                = "ec2-swarm"
        area                = "networking"
    }
}

# Associate route table with subnet in VPC
resource "aws_route_table_association" "ec2_swarm_rta" {
    subnet_id               = "${aws_subnet.ec2_swarm_public.id}"
    route_table_id          = "${aws_route_table.ec2_swarm_routes.id}"
}
