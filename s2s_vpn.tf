resource "aws_vpn_connection" "s2s" {
    customer_gateway_id = aws_customer_gateway.on_prem.id
    vpn_gateway_id = aws_vpn_gateway.vgw.id
    type = "ipsec.1"
    static_routes_only = true

    tunnel1_preshared_key = var.vpn_psk
    tunnel2_preshared_key = var.vpn_psk

    tags = {
      Name = "One-Prem to AWS-VPN"
    }
}

resource "aws_vpn_connection_route" "to_onprem" {
    vpn_connection_id = aws_vpn_connection.s2s.id
    destination_cidr_block =  var.on_prem_cidr
}