



module "redshift" {
  source  = "terraform-aws-modules/redshift/aws"
  version = "~> 2.0"

  cluster_identifier      = "my-cluster"
  cluster_node_type       = "dc1.large"
  cluster_number_of_nodes = 1

  cluster_database_name   = "mydb"
  cluster_master_username = "mydbuser"
  cluster_master_password = "mySecretPassw0rd"

  # Group parameters
  wlm_json_configuration = "[{\"query_concurrency\": 5}]"

  # DB Subnet Group Inputs
  subnets = ["subnet-123456", "subnet-654321"]

  # IAM Roles
  cluster_iam_roles = ["arn:aws:iam::225367859851:role/developer"]

//  tags = var.tags
  vpc_security_group_ids = var.vpc_security_group_ids
}