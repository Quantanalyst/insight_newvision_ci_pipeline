output "public_ip" {
  value       = aws_eip.this.public_ip
  description = "The public IP of the instance created"
}

output "instance_id" {
  value       = aws_instance.airflow_rstudio.id
  description = "The instance ID created"
}

output "key_name" {
  value       = join("", aws_key_pair.this.*.key_name)
  description = "The key pair name created"
}

output "dns_name" {
  value       = aws_efs_file_system.this.dns_name
  description = "EFS DNS name"
}

output "mount_target_ids" {
  value       = aws_efs_mount_target.this.id
  description = "List of EFS mount target IDs (one per Availability Zone)"
}

output "url-airflow" {
  value = "http://${aws_eip.this.public_ip}:8080"
}