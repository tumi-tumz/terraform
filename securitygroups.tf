# Create Security Group for resources in public Subnets
resource "aws_security_group" "rdgw" {
  name = "Custom-RGDW-sg"
  description = "Allow access to webservers"
  vpc_id = aws_vpc.custom.id

  # Inbound rules
  ingress = [ {
    description = "All TLS from VPC"
    cidr_blocks = [var.vpcCIDRblock]
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    ipv6_cidr_blocks = null
    prefix_list_ids = null
    security_groups = null
    self = null
  },
  {
    description = "HTTPS from anywhere"
    cidr_blocks = [var.allCIDRblock]
    from_port = 443
    to_port = 443
    protocol = "tcp"
    ipv6_cidr_blocks = null
    prefix_list_ids = null
    security_groups = null
    self = null
  }]

  # Outbound rules
  egress = [ {
    cidr_blocks = [var.allCIDRblock]
    description = null
    from_port = 0
    ipv6_cidr_blocks = null
    prefix_list_ids = null
    protocol = "-1"
    security_groups = null
    self = false
    to_port = 0
  } ]

  tags = {
    "Name" = "Custom-RGDW-sg"
  }
}

# Create Security Group for resources in private Subnets
resource "aws_security_group" "pvt" {
  name = "Custom-private-sg"
  description = "Allow access to resources in private subnets"
  vpc_id = aws_vpc.custom.id

  # Inbound rules
  ingress = [ {
    description = "All TLS from VPC"
    cidr_blocks = [var.vpcCIDRblock]
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    ipv6_cidr_blocks = null
    prefix_list_ids = null
    security_groups = null
    self = null
  }]

  # Outbound rules
  egress = [ {
    cidr_blocks = [var.allCIDRblock]
    description = null
    from_port = 0
    ipv6_cidr_blocks = null
    prefix_list_ids = null
    protocol = "-1"
    security_groups = null
    self = false
    to_port = 0
  } ]

  tags = {
    "Name" = "Custom-private-sg"
  }
}

# Create Security Group for resources in database servers
resource "aws_security_group" "db" {
  name = "Custom-database-sg"
  description = "Allow access to database servers"
  vpc_id = aws_vpc.custom.id

  # Inbound rules
  ingress = [ {
    description = "SQL Server from VPC"
    cidr_blocks = [var.vpcCIDRblock]
    from_port = 1433
    to_port = 1433
    protocol = "tcp"
    ipv6_cidr_blocks = null
    prefix_list_ids = null
    security_groups = null
    self = null
  },
  {
    description = "MySQL Server from VPC"
    cidr_blocks = [var.vpcCIDRblock]
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    ipv6_cidr_blocks = null
    prefix_list_ids = null
    security_groups = null
    self = null
  },
  {
    description = "PostgreSQL Server from VPC"
    cidr_blocks = [var.vpcCIDRblock]
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    ipv6_cidr_blocks = null
    prefix_list_ids = null
    security_groups = null
    self = null
  }]

  # Outbound rules
  egress = [ {
    cidr_blocks = [var.allCIDRblock]
    description = null
    from_port = 0
    ipv6_cidr_blocks = null
    prefix_list_ids = null
    protocol = "-1"
    security_groups = null
    self = false
    to_port = 0
  } ]

  tags = {
    "Name" = "Custom-database-sg"
  }
}

# Create Security Group for resources in database servers
resource "aws_security_group" "lb" {
  name = "Custom-alb-sg"
  description = "Allow access to Application Load Balancer"
  vpc_id = aws_vpc.custom.id

  # Inbound rules
  ingress = [ {
    description = "HTTP Traffic"
    cidr_blocks = [var.allCIDRblock]
    from_port = 80
    to_port = 80
    protocol = "tcp"
    ipv6_cidr_blocks = null
    prefix_list_ids = null
    security_groups = null
    self = null
  },
  {
    description = "HTTPS Traffic"
    cidr_blocks = [var.allCIDRblock]
    from_port = 443
    to_port = 443
    protocol = "tcp"
    ipv6_cidr_blocks = null
    prefix_list_ids = null
    security_groups = null
    self = null
  }]

  # Outbound rules
  egress = [ {
    cidr_blocks = [var.allCIDRblock]
    description = null
    from_port = 0
    ipv6_cidr_blocks = null
    prefix_list_ids = null
    protocol = "-1"
    security_groups = null
    self = false
    to_port = 0
  } ]

  tags = {
    "Name" = "Custom-alb-sg"
  }
}

# Create Security Group for test resources
resource "aws_security_group" "tst" {
  name = "Custom-test-sg"
  description = "Allow ssh access to test resources"
  vpc_id = aws_vpc.custom.id

  # Inbound rules
  ingress = [ {
    description = "All SSH access"
    cidr_blocks = [var.allCIDRblock]
    from_port = 22
    to_port = 22
    protocol = "tcp"
    ipv6_cidr_blocks = null
    prefix_list_ids = null
    security_groups = null
    self = null
  }]

  # Outbound rules
  egress = [ {
    cidr_blocks = [var.allCIDRblock]
    description = null
    from_port = 0
    ipv6_cidr_blocks = null
    prefix_list_ids = null
    protocol = "-1"
    security_groups = null
    self = false
    to_port = 0
  } ]

  tags = {
    "Name" = "Custom-test-sg"
  }
}

