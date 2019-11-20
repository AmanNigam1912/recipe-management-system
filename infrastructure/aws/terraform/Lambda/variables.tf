variable "region" {
    type = "string"
}

variable "profile" {
    description = "Enter the environment (dev/prod):"
}

variable "domain" {
    type = "string"
}

variable "aws_security_group_protocol" {
    type = "string"
    #tcp
}

variable "ami" {
    type = "string"
}

variable "key_name" {
    type = "string"
}