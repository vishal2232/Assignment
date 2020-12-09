module "vpc" {
 source = "../../../../../modules/vpc/"
 
 name = "${var.project}-${var.environment}-vpc"
 cidr = var.vpc_cidr
 
 azs                 = ["us-east-1a", "us-east-1b"]
 private_subnets     = local.private_subnets
 public_subnets      = local.public_subnets
 database_subnets    = local.database_subnets
 
 enable_nat_gateway           = true
 single_nat_gateway           = false
 one_nat_gateway_per_az       = true
 enable_vpn_gateway           = false
 public_dedicated_network_acl = true
 
 create_database_subnet_group = false
 enable_dns_hostnames         = true
 enable_dns_support           = true
 
 enable_classiclink             = false
 enable_classiclink_dns_support = false
 customer_gateways              = {}
 
 tags = {
   Owner       = "infra-internal@project.net"
   Environment = "${var.environment}"
   Project     = "${var.project}"
 }
 
 vpc_endpoint_tags = {
   Owner       = "infra-internal@project.net"
   Environment = "${var.environment}"
   Project     = "${var.project}"
 }
}
