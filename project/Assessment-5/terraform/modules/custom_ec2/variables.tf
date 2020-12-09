variable "project" {
 description = "Project Name"
 type        = string
 default = "infra"
}
variable "owner" {
 description = "Owner Name"
 type        = string
 default = "infra"
}
variable "category" {
 description = "Category Name"
 type        = string
 default = "infra"
}
variable "environment" {
 description = "Environment Name"
 type        = string
 default = "test"
}
variable "vpc_cidr" {
 description = "VPC Cidr"
 type        = string
 default = "10.0.0.0/16"
}
variable "ami_id" {
 description = "AMI ID"
 type        = string
 default = "ami-03b9e252f8535d9f3"
}
 
