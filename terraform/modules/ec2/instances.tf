resource "aws_instance" "myec2" {
  count = "${var.ec2_count}"
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id}"

  tags = {
    Name = "my_ec2_instance"
  }
}





