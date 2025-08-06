resource "aws_customer_gateway" "on_prem" {
    bgp_asn = 65000 # required but not used in static routing
    ip_address = var.customer_gateway_ip
    type = "ipsec.1"

    tags = {
      Name = "On-Prem CGW"
    }
}