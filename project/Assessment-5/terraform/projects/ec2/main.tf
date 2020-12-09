module "application_server" {
 source                 = "../../../../../modules/custom_ec2_module/"
 
 name                   = "test-machine"
 instance_count         = 1
 private_ip             = "10.0.0.1"
 ami                    = "ami-005e986907a395af4"
 instance_type          = "t3a.xlarge"
 key_name               = "test"
 monitoring             = true
 securitygroup_regex = ["${var.environment}-application"]
 subnet_regex = ["*private*"]
 vpc_cidr = "10.0.0.0/16"
 availability_zone = "us-east-1a"
 vpc_name_regex = ["test-vpc*"]
 
}
