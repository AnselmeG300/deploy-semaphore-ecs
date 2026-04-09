resource "aws_network_acl" "public_network_acl" {
  vpc_id = aws_vpc.semaphore.id

  # ─── INGRESS DENY RULES (85-99) ───────────────────────────────────────────

  ingress {
    protocol   = "-1"
    rule_no    = 85
    action     = "deny"
    cidr_block = "220.167.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 86
    action     = "deny"
    cidr_block = "58.212.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 87
    action     = "deny"
    cidr_block = "59.173.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 88
    action     = "deny"
    cidr_block = "125.82.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 89
    action     = "deny"
    cidr_block = "14.135.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 90
    action     = "deny"
    cidr_block = "112.112.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 91
    action     = "deny"
    cidr_block = "121.29.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 92
    action     = "deny"
    cidr_block = "123.145.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 93
    action     = "deny"
    cidr_block = "60.13.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 94
    action     = "deny"
    cidr_block = "42.48.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 95
    action     = "deny"
    cidr_block = "116.178.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 96
    action     = "deny"
    cidr_block = "182.138.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 97
    action     = "deny"
    cidr_block = "123.245.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 98
    action     = "deny"
    cidr_block = "171.105.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 99
    action     = "deny"
    cidr_block = "175.30.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  # ─── INGRESS ALLOW ALL (règle 100 — évaluée après les deny) ──────────────

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Network = "Public"
    Name    = join("", [var.vpc_name, "-public-nacl"])
  }
}


resource "aws_network_acl_association" "public_subnet_network_acl_association" {
  subnet_id      = aws_subnet.public_subnet.id
  network_acl_id = aws_network_acl.public_network_acl.id
}


resource "aws_network_acl_association" "public_subnet_network_acl_association1" {
  count          = var.activated_auto_scaling ? 1 : 0
  subnet_id      = aws_subnet.public_subnet1.id
  network_acl_id = aws_network_acl.public_network_acl.id
}


resource "aws_network_acl" "private_network_acl" {
  vpc_id = aws_vpc.semaphore.id

  # ─── INGRESS DENY RULES (85-99) ───────────────────────────────────────────

  ingress {
    protocol   = "-1"
    rule_no    = 85
    action     = "deny"
    cidr_block = "220.167.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 86
    action     = "deny"
    cidr_block = "58.212.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 87
    action     = "deny"
    cidr_block = "59.173.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 88
    action     = "deny"
    cidr_block = "125.82.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 89
    action     = "deny"
    cidr_block = "14.135.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 90
    action     = "deny"
    cidr_block = "112.112.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 91
    action     = "deny"
    cidr_block = "121.29.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 92
    action     = "deny"
    cidr_block = "123.145.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 93
    action     = "deny"
    cidr_block = "60.13.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 94
    action     = "deny"
    cidr_block = "42.48.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 95
    action     = "deny"
    cidr_block = "116.178.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 96
    action     = "deny"
    cidr_block = "182.138.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 97
    action     = "deny"
    cidr_block = "123.245.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 98
    action     = "deny"
    cidr_block = "171.105.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 99
    action     = "deny"
    cidr_block = "175.30.0.0/16"
    from_port  = 0
    to_port    = 0
  }

  # ─── INGRESS ALLOW ALL (règle 100 — évaluée après les deny) ──────────────

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Network = "Private"
    Name    = join("", [var.vpc_name, "-private-nacl"])
  }
}

resource "aws_network_acl_association" "private_subnet_network_acl_association" {
  subnet_id      = aws_subnet.private_subnet.id
  network_acl_id = aws_network_acl.private_network_acl.id
}


resource "aws_network_acl_association" "private_subnet_network_acl_association1" {
  count          = var.activated_auto_scaling ? 1 : 0
  subnet_id      = aws_subnet.private_subnet1[0].id
  network_acl_id = aws_network_acl.private_network_acl.id
}