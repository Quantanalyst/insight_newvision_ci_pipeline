variable "aws_region" {
  default = "us-west-2"
}

variable "postgrespassword" {
  default = "demopass"
}

variable "public_key_path" {
  description = "path to public key"
  type = string
  # default = "path to something"
}

# variable "create" {
#   description = "Bool to create"
#   type        = bool
#   default     = true
# }

# variable "id" {
#   description = "The id of the resources"
#   type        = string
# }

# variable "tags" {
#   description = "Tags for resources"
#   type        = map(string)
#   default     = {}
# }

# variable "vpc_id" {}

# variable "subnet_ids" {
#   type = list(string)
# }

# variable "vpc_security_group_ids" {
#   type = list(string)
# }

