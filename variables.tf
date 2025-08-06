variable "customer_gateway_ip" {
    description = "Public IP address of your on-premStringSwan VPN server"
    type = string
}

variable "vpn_psk" {
    description = "Pre-shared key for the VPN tunnels"
    type = string
}

variable "on_prem_cidr" {
    description = "CIDR block of on-prem (StrongSwan) network"
    type = string
}

variable "ec2_ami" {
    description = "AMI ID for the EC2 instance"
    type = string
}

variable "ec2_instance_type" {
    description = "EC2 instance type"
    type = string
    default = "t3.micro"
}

variable "key_pair_name" {
    description = "Name of the existing EC2 key pair"
    type = string
}