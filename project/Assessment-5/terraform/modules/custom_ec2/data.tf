data "aws_vpc" "vpc" {
 tags = {
   Name = "${var.project}*"
 }
}
 
 
data "aws_subnet_ids" "subnet" {
 vpc_id = data.aws_vpc.vpc.id
 
 tags = {
   Name = "*private*"
 }
}
 
 
data "aws_security_group" "security_group" {
 vpc_id = data.aws_vpc.vpc.id
 filter {
   name    = "tag:Name"
   values  = ["${var.project}-${var.env}-security-group"]
 }
}

