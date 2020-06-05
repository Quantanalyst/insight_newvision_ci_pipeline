
# reference: Terraforming and Connecting to an AWS Redshift Cluster
# link: https://medium.com/faun/terraforming-and-connecting-to-your-aws-redshift-cluster-16f93ddd41cc

resource "aws_redshift_cluster" "main" {
  cluster_identifier = "tf-redshift-cluster"
  database_name      = "newvisionredshift"
  master_username    = "root"
  master_password    = "mySecretPassw0rd"
  node_type          = "dc1.large"
  cluster_type       = "single-node"
  port               = 5439
  cluster_subnet_group_name = aws_redshift_subnet_group.redshift-subnet.name
  vpc_security_group_ids = [aws_security_group.allow-redshift.id]
  skip_final_snapshot = true
  publicly_accessible = true
  iam_roles = [aws_iam_role.redshift_role.arn]
}
