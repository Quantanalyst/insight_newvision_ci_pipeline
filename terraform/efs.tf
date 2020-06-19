resource "aws_efs_file_system" "this" {
  creation_token = var.name

  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )
}

resource "aws_efs_mount_target" "this" {
  file_system_id  = aws_efs_file_system.this.id
  # subnet_id       = var.subnet_id
  subnet_id       = aws_subnet.main-public-1.id
  security_groups = [aws_security_group.airflow_security_group.id]
}