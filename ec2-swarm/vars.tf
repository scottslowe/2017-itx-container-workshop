variable "keypair" {
    type                    = "string"
    description             = "SSH keypair to use to connect to instances"
    default                 = "KEYPAIR" # Specify name of an AWS keypair to use
}

variable "mgr_flavor" {
    type                    = "string"
    description             = "AWS type to use when creating instances"
    default                 = "t2.small"
}

variable "wkr_flavor" {
    type                    = "string"
    description             = "AWS type to use when creating instances"
    default                 = "t2.micro"
}

variable "user_region" {
    type                    = "string"
    description             = "AWS region to use by default"
    default                 = "us-west-2"
}
