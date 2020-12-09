resource "aws_instance" "as" {
 count                       = "${var.instance_count}"
 ami                         = "${var.ami}"
 instance_type               = "${var.instance_type}"
 key_name                    = "${var.key_name}"
 monitoring                  = true
 private_ip                  = "${var.private_ip}"
 vpc_security_group_ids      = data.aws_security_group.security_group.id
 subnet_id                   = data.aws_subnet_ids.subnet.ids
 disable_api_termination     = "false"
 root_block_device = {
     volume_type           = "gp2"
     volume_size           = "50"
     delete_on_termination = "false"
     }
 
 tags  {
 
         Project  = "${var.project}"
         Owner    = "${var.owner}"
         Env      = "${var.env}"
         Category = "application_server"
    }
 
 volume_tags {
     Project       = "${var.project}"
     Owner         = "${var.owner}"
     Env           = "${var.env}"
     Category      = "application_server"
 }
}


