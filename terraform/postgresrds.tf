# reference: Creating RDS instance using Terraform
# link: https://geekdudes.wordpress.com/2018/02/12/creating-rds-instance-using-terraform/

#------------------------------------------------------------
# Database configuration
#------------------------------------------------------------
# resource "aws_db_instance" "postgres" {
#     allocated_storage = 100  # 100 GB of storage, gives us more IOPS than a lower number 
#     max_allocated_storage = 200 # provides storage autoscaling
#     engine = "postgres"
#     engine_version = "12.2"
#     instance_class = "db.t2.small"
#     identifier = "postgresdb"
#     name = "postgresdb"
#     username = "root"
#     password = var.postgrespassword
#     db_subnet_group_name = aws_db_subnet_group.postgres-subnet.name
#     parameter_group_name = aws_db_parameter_group.postgres-parameters.id
#     multi_az = "false"
#     vpc_security_group_ids = [aws_security_group.allow-postgres.id]
#     storage_type = "gp2"
#     backup_retention_period = 30
#     availability_zone = aws_subnet.main-private-1.availability_zone # Preferred AZ
#     storage_encrypted = false
#     skip_final_snapshot = true
#     tags = {
#         Name = "postgres-instance"
#     }
# }

#------------------------------------------------------------
# Database parameters group
#------------------------------------------------------------
# List of Amazon RDS (PostgreSQL) parameters
# Link: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.PostgreSQL.CommonDBATasks.html#Appendix.PostgreSQL.CommonDBATasks.Parameters
# resource "aws_db_parameter_group" "postgres-parameters" {
#     name = "postgres-parameters"
#     family = "postgres12"
#     description = "PostgreSQL parameter group"

#     # parameter {
#     #     name = "max_allowed_packet"
#     #     value = "16777216"
#     # }
# }