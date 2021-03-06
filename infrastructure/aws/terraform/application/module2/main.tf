module "module1" {
   source = "../../"

   cidrVpc = "${var.cidrVpc}"
   vpcName = "${var.vpcName}"
   subnetCidrBlock = "${var.subnetCidrBlock}"
   subnetName = "${var.subnetName}"
   internetGatewayName = "${var.internetGatewayName}"
   routeTableName = "${var.routeTableName}"
   region = "${var.region}"
   subnetCount = "${var.subnetCount}"
   subnetZones = "${var.subnetZones}"
   profile = "${var.profile}"
   aws_security_group_protocol = "${var.aws_security_group_protocol}" 
   db_name = "${var.db_name}"
   db_engine = "${var.db_engine}"
   db_engine_version = "${var.db_engine_version}"
   db_instance = "${var.db_instance}"
   db_multi_az = "${var.db_multi_az}"
   db_identifier = "${var.db_identifier}"
   db_username = "${var.db_username}"
   db_password = "${var.db_password}"
   db_publicly_accessible = "${var.db_publicly_accessible}"
}