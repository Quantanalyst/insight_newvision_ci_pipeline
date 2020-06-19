module "ami" {
  source = "github.com/insight-infrastructure/terraform-aws-ami.git?ref=v0.1.0"
}

resource "aws_eip" "this" {
  tags = var.tags
}

resource "aws_eip_association" "this" {
  instance_id = aws_instance.airflow_rstudio.id
  public_ip   = aws_eip.this.public_ip
}

resource "aws_key_pair" "this" {
  count      = var.public_key_path == "" ? 0 : 1
  public_key = file(var.public_key_path)
  tags       = var.tags
}

resource "aws_instance" "airflow_rstudio" {
  ami           = module.ami.ubuntu_1804_ami_id
  instance_type = var.instance_type

  # subnet_id              = var.subnet_id
  subnet_id              = aws_subnet.main-public-1.id
  vpc_security_group_ids = [aws_security_group.airflow_security_group.id]
  key_name               = var.public_key_path == "" ? var.key_name : aws_key_pair.this.*.key_name[0]
  iam_instance_profile   = aws_iam_instance_profile.this.id
  associate_public_ip_address = true

  provisioner "file" {
    connection {
      host        = "${aws_instance.airflow_rstudio.public_ip}"
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file(var.private_key)}"
      }

    source      = "provisioners/"
    destination = "/tmp"
  }

  # provisioner "remote-exec" {
  #   connection {
  #     host        = "${aws_instance.airflow_rstudio.public_ip}"
  #     type        = "ssh"
  #     user        = "ubuntu"
  #     private_key = "${file(var.private_key)}"
  #   }

  #   inline = [
  #     "sudo sh /tmp/install-R.sh",
  #     # "sudo mv /tmp/dag_test_source_code.py /etc/airflow/dags",
  #     # "sudo airflow usnpause source_code_change_tests && sudo airflow trigger_dag source_code_change_tests",
  #   ]
  # }


  root_block_device {
    volume_size = var.root_volume_size
  }

  tags = var.tags
}


module "ansible" {
  source           = "github.com/insight-infrastructure/terraform-aws-ansible-playbook.git?ref=v0.8.0"
  ip               = aws_eip_association.this.public_ip
  user             = "ubuntu"
  private_key_path = var.private_key_path

  playbook_file_path = "${path.module}/ansible/main.yml"
  playbook_vars = merge({
    file_system_id = aws_efs_file_system.this.id,
  }, var.playbook_vars)

  requirements_file_path = "${path.module}/ansible/requirements.yml"
}

