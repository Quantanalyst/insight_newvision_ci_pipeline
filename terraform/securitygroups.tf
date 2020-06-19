#------------------------------------------------------------
# Data sources to get security group details
#------------------------------------------------------------
data "aws_security_group" "default" {
  vpc_id = aws_vpc.default.id
  name   = "default"
}

#------------------------------------------------------------
# Database security group
#------------------------------------------------------------

# security group for SSH connection
resource "aws_security_group" "allow-ssh" {
    vpc_id = aws_vpc.default.id
    name = "allow-ssh"
    description = "allow-ssh"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "allow-ssh"
    }
  
}

# security group for redshift
resource "aws_security_group" "allow-redshift" {
    vpc_id = aws_vpc.default.id
    name = "allow-redshift"
    description = "allow-redshift"

    ingress {
        from_port = 5439
        to_port = 5439
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        self = true
    }

    tags = {
        Name = "allow-redshift"
    }
}


# security group for airflow_rstudio resource
resource "aws_security_group" "airflow_security_group" {
  name        = "airflow_security_group"
  description = "control access to the workflow management server"
  vpc_id = aws_vpc.default.id
}

# open all ports temporarily
resource "aws_security_group_rule" "openaccess" {
  security_group_id = "${aws_security_group.airflow_security_group.id}"
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
}

# allow reply traffic from the server to the internet on ephemeral ports
resource "aws_security_group_rule" "egress_reply" {
  security_group_id = "${aws_security_group.airflow_security_group.id}"
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "all"
  from_port         = 0
  to_port           = 0
}
