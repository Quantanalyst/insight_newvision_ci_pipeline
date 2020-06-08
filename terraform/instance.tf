data "aws_ami" "centos" {
  owners      = ["679593333241"]
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

resource "aws_key_pair" "publickey" {
  public_key = file(var.public_key_path)
}

resource "aws_instance" "rstudio_server" {
  count         = 1
  ami           = data.aws_ami.centos.id 
  instance_type = "t2.micro"

  key_name = aws_key_pair.publickey.key_name
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  subnet_id = aws_subnet.main-public-3.id

  # Ansible requires Python to be installed on the remote machine as well as the local machine.
#   provisioner "remote-exec" {
#     inline = ["sudo yum install -y python3"]
#   }

  tags = {
    Name = "rstudio_server"
  }
}