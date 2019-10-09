data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = "${var.cidrVpc}"

  tags = {
      Name = "${var.vpcName}"
  }
}

resource "aws_subnet" "main" {
  count = 3

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = "${aws_vpc.main.id}"

  tags = {
      Name = "subnetMain"
  }
}

resource "aws_internet_gateway" "main" {    
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "terraform-eks-main"
  }
}

resource "aws_route_table" "main" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "${var.cidrRouteTable}"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags = {
      Name = "routeTable"
  }
}

resource "aws_route_table_association" "main" {
  count = 3

  subnet_id      = "${aws_subnet.main.*.id[count.index]}"
  route_table_id = "${aws_route_table.main.id}"
}