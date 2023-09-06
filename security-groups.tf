
resource "aws_security_group" "baseline-access-sg" {
    name        = "${var.accountname}-${var.environment}-SG"
    description = "Access Security Group"
    vpc_id      = var.vpc_id
        
} 


resource "aws_security_group_rule" "egress_tcp_baseline-access-sg" {
    description         = "Allow All Outbound tcp" 
    type                = "egress"
    protocol            = "tcp"
    from_port           = 0
    to_port             = 0
    cidr_blocks         = [var.any-any]
    security_group_id   = aws_security_group.baseline-access-sg.id
}

resource "aws_security_group_rule" "egress_udp_baseline-access-sg" {
    description         = "Allow All Outbound udp" 
    type                = "egress"
    protocol            = "udp"
    from_port           = 0
    to_port             = 0
    cidr_blocks         = [var.any-any]
    security_group_id   = aws_security_group.baseline-access-sg.id
}

resource "aws_security_group_rule" "ingress_tcp_22-baseline-access-sg" {
    description         = "Allow inbound tcp 22" 
    type                = "ingress"
    protocol            = "tcp"
    from_port           = 22
    to_port             = 22
    cidr_blocks         = [var.ssh-access]
    security_group_id   = aws_security_group.baseline-access-sg.id
}

resource "aws_security_group_rule" "ingress_tcp_53-baseline-access-sg" {
    description         = "Allow inbound tcp 53"
    type                = "ingress"
    protocol            = "tcp"
    from_port           = 53
    to_port             = 53
    cidr_blocks         = [var.any-any]
    security_group_id   = aws_security_group.baseline-access-sg.id
}

resource "aws_security_group_rule" "ingress_udp_53-baseline-access-sg" {
    description         = "Allow inbound udp 53"
    type                = "ingress"
    protocol            = "udp"
    from_port           = 53
    to_port             = 53
    cidr_blocks         = [var.any-any]
    security_group_id   = aws_security_group.baseline-access-sg.id
}

resource "aws_security_group_rule" "ingress_tcp_443-baseline-access-sg" {
    description         = "Allow inbound tcp 443"
    type                = "ingress"
    protocol            = "tcp"
    from_port           = 443
    to_port             = 443
    cidr_blocks         = [var.any-any]
    security_group_id   = aws_security_group.baseline-access-sg.id
}
