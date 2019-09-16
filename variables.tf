variable "region" {
  description = "Defines the AWS region."
}
variable "profile" {
  default = "default"
  description = "Defines the AWS profile."
}
variable "project_name" {
  description = "Project name, will be used for tagging purposes."
}
variable "public_key" {
  description = "The SSH public key that you would like to use."
}
variable "http_srv_instance_type" {
  description = "Defines the type of the instance for a http server."
}
variable "autoscaling_group_min_size" {
  description = "Defines the minimum number of instances running in the AS group."
}
variable "autoscaling_group_max_size" {
  description = "Defines the maximum number of instances running in the AS group."
}

/* Assign the variable in *.tfvars file(s) with a comma separated list of CIDR blocks you would like to allow.
You can authorise combinations of specific IP addresses and / or IP address ranges */

variable "allowed_cidr_blocks" {
  type = "list"
  description = "Defines the IP range allowed to connect."
}

