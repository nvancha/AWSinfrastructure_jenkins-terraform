# Fetch Available Availability Zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Create the VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create an Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main_vpc.id
}

# Create 2 Public Subnets
resource "aws_subnet" "public_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
}

# Create 2 Private Subnets
resource "aws_subnet" "private_subnet" {
  count              = 2
  vpc_id             = aws_vpc.main_vpc.id
  cidr_block         = "10.0.${count.index + 2}.0/24"
  availability_zone  = element(data.aws_availability_zones.available.names, count.index)
}

# Create Route Tables for Public Subnets and associate with the Internet Gateway
resource "aws_route_table" "public_route_table" {
  count = 2
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  count          = 2
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table[count.index].id
}

# Create Route Tables for Private Subnets
resource "aws_route_table" "private_route_table" {
  count = 2
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route_table_association" "private_subnet_association" {
  count          = 2
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table[count.index].id
}

# Create Network ACLs for each subnet
resource "aws_network_acl" "subnet_nacl" {
  count = 4
  vpc_id = aws_vpc.main_vpc.id

  # Add rules as needed
  ingress {
    protocol   = "6" # TCP
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  egress {
    protocol   = "6" # TCP
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}

# Associate NACLs with Subnets
resource "aws_network_acl_association" "nacl_association" {
  count          = 4
  network_acl_id = aws_network_acl.subnet_nacl[count.index].id
  subnet_id      = element(concat(aws_subnet.public_subnet.*.id, aws_subnet.private_subnet.*.id), count.index)
}
