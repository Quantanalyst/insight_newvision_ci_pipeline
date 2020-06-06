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
resource "aws_security_group" "allow-postgres" {
    vpc_id = aws_vpc.default.id
    name = "allow-postgres"
    description = "allow-postgres"

    ingress {
        from_port = 3306
        to_port = 3306
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
        Name = "allow-postgres"
    }
}


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