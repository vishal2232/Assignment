locals {
   subnets = cidrsubnets(var.vpc_cidr, 6, 6, 6, 6, 6, 6)
   private_subnets = [element(local.subnets,0),element(local.subnets,1)]
   public_subnets = [element(local.subnets,2),element(local.subnets,3)]
   database_subnets = [element(local.subnets,4),element(local.subnets,5)]
}
