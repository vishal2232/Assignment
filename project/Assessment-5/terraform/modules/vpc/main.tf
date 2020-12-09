module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version                = "~> 2.0"
  name = var.name
  cidr = var.cidr
  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  database_subnets    = var.database_subnets
  elasticache_subnets = var.elasticache_subnets
  redshift_subnets    = var.redshift_subnets
  intra_subnets       = var.intra_subnets
  
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = false
  one_nat_gateway_per_az = true
  enable_vpn_gateway = var.enable_vpn_gateway
  public_dedicated_network_acl = var.public_dedicated_network_acl

  create_database_subnet_group = var.create_database_subnet_group
  create_redshift_subnet_group = var.create_redshift_subnet_group

  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  enable_classiclink             = var.enable_classiclink
  enable_classiclink_dns_support = var.enable_classiclink_dns_support

  customer_gateways = var.customer_gateways

  tags = var.tags
  redshift_subnet_tags = {
    resource = "redshift"
  }
  database_subnet_tags = {
    resource = "database"
  }
  vpc_endpoint_tags = var.vpc_endpoint_tags

}
