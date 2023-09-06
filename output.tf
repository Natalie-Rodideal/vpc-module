output "region" {
  value = var.region
}

output "accountname" {
  value = var.accountname
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet1_id" {
  value = aws_subnet.private_subnet1.id
}

output "public_subnet2_id" {
  value = aws_subnet.private_subnet2.id
}

output "private_subnet1_id" {
  value = aws_subnet.private_subnet1.id
}

output "private_subnet2_id" {
  value = aws_subnet.private_subnet2.id
}

output "aws_internet_gateway" {
  value = aws_internet_gateway.internet_gateway
}

output "tgw_id" {
    description = "ID for the Transit Gateway US-EAST-01"
    value       = var.tgw_id
}

output "tgw_attachment" {
    description = "ID for the tgw attachment"
    value       = aws_ec2_transit_gateway_vpc_attachment.tgw_attachment
}

output "route53-outboundresolver-rule_id" {
  description = "ID for the Shared Route53-Outbound-Resolver-Rule"
  value       = var.route53-outboundresolver-rule_id
}
