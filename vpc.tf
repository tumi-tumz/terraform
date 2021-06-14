# Build a custom VPC
resource "aws_vpc" "custom" {
  # You can change the CIDR according to your preference.
  cidr_block = var.vpcCIDRblock
  instance_tenancy = "default"
  tags = {
    "Name" = var.vpcname
  }
}
# Add Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.custom.id

  tags = {
    Name = "IGW"
  }
}
# Attach Internet Gateway to Default Route Table
resource "aws_default_route_table" "dfroute" {
  default_route_table_id = aws_vpc.custom.default_route_table_id
  route  {
    cidr_block = var.allCIDRblock
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    "Name" = "DefaultRoute"
  }
}
# Associate Public Subnets with Default Route Table
resource "aws_route_table_association" "pub1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_default_route_table.dfroute.id
}
resource "aws_route_table_association" "pub2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_default_route_table.dfroute.id
}
# Add subnets to the VPC.
resource "aws_subnet" "public1" {
  vpc_id = aws_vpc.custom.id
  availability_zone = var.az1
  cidr_block = var.pub1CIDRblock
  map_public_ip_on_launch = true
  tags = {
    "Name" = var.pub1name
  }
}
resource "aws_subnet" "private1" {
  vpc_id = aws_vpc.custom.id
  availability_zone = var.az1
  cidr_block = var.pvt1CIDRblock
  tags = {
    "Name" = var.pvt1name
  }
}
resource "aws_subnet" "public2" {
  vpc_id = aws_vpc.custom.id
  availability_zone = var.az2
  cidr_block = var.pub2CIDRblock
  map_public_ip_on_launch = true
  tags = {
    "Name" = var.pub2name
  }
}
resource "aws_subnet" "private2" {
  vpc_id = aws_vpc.custom.id
  availability_zone = var.az2
  cidr_block = var.pvt2CIDRblock
  tags = {
    "Name" = var.pvt2name
  }
}
# Get Elastic IPs
resource "aws_eip" "nat1" {
 depends_on = [
   aws_internet_gateway.gw
 ]
}
resource "aws_eip" "nat2" {
 depends_on = [
   aws_internet_gateway.gw
 ]
}
# Add NAT Gateways
resource "aws_nat_gateway" "nat1" {
  allocation_id = aws_eip.nat1.id
  subnet_id = aws_subnet.public1.id
}
resource "aws_nat_gateway" "nat2" {
  allocation_id = aws_eip.nat2.id
  subnet_id = aws_subnet.public2.id
}
# Create custom Route Tables
resource "aws_route_table" "route1" {
  vpc_id =  aws_vpc.custom.id
  tags = {
    "Name" = var.route1name
  }
}
# Create custom Route Tables
resource "aws_route_table" "route2" {
  vpc_id =  aws_vpc.custom.id
  tags = {
    "Name" = var.route2name
  }
}
# Add NAT to Route Table
resource "aws_route" "route1" {
  route_table_id = aws_route_table.route1.id
  destination_cidr_block = var.allCIDRblock
  gateway_id = aws_nat_gateway.nat1.id
  }
  resource "aws_route" "route2" {
  route_table_id = aws_route_table.route2.id
  destination_cidr_block = var.allCIDRblock
  gateway_id = aws_nat_gateway.nat2.id
  }
# Associate Private Subnets with Custom Route Table
resource "aws_route_table_association" "pvt1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.route1.id
}
resource "aws_route_table_association" "pvt2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.route2.id
}