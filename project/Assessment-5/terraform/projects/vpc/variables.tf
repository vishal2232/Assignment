variable "project" {
 description = "Project Name"
 type        = string
 default     = "infra"
}
variable "environment" {
 description = "Environment Name"
 type        = string
 default     = "dummy"
}
 
variable "vpc_cidr" {
 description = "VPC CIDR"
 type        = string
 default     = "10.0.0.0/16"
}
