#------------------------------------------------------------
# Provider: AWS
#------------------------------------------------------------
provider "aws" {
  region = "us-west-2"
}

#------------------------------------------------------------
# Data sources to get VPC, subnets and security group details
#------------------------------------------------------------

resource "aws_vpc" "default" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags = {
        Name = "default"
    }
}

data "aws_subnet_ids" "all" {
  vpc_id = aws_vpc.default.id
}

data "aws_security_group" "default" {
  vpc_id = aws_vpc.default.id
  name   = "default"
}

#------------------------------------------------------------
# Database configuration
#------------------------------------------------------------
resource "aws_db_instance" "postgres" {
    allocated_storage = 20
    max_allocated_storage = 100 # provides storage autoscaling
    engine = "postgres"
    engine_version = "12.2"
    instance_class = "db.t2.micro"
    identifier = "postgresdb"
    name = "postgresdb"
    username = "root"
    password = "demopass"
    db_subnet_group_name = aws_db_subnet_group.postgres-subnet.name
    parameter_group_name = "postgres-parameters"
    multi_az = "false"
    vpc_security_group_ids = [aws_security_group.allow-postgres.id]
    storage_type = "gp2"
    backup_retention_period = 30
    availability_zone = aws_subnet.main-private-1.availability_zone # Preferred AZ
    storage_encrypted = false
    tags = {
        Name = "postgres-instance"
    }
}

#------------------------------------------------------------
# Database parameters group
#------------------------------------------------------------
resource "aws_db_parameter_group" "postgres-parameters" {
    name = "postgres-parameters"
    family = "postgres12"
    description = "PostgreSQL parameter group"

    parameter{
        name = "max_allowed_packet"
        value = "16777216"
    }
}

#------------------------------------------------------------
# Database subnet group
#------------------------------------------------------------
resource "aws_subnet" "main-private-1" {
    vpc_id = aws_vpc.default.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-west-2a"

    tags = {
        Name = "main-private-1"
    }
}
resource "aws_subnet" "main-private-2" {
    vpc_id = aws_vpc.default.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-west-2b"

    tags = {
        Name = "main-private-2"
    }
}

resource "aws_db_subnet_group" "postgres-subnet" {
    name = "postgres-subnet"
    description = "RDS subnet group"
    # this subnet group specifies that the RDS will be put in a private subnet
    subnet_ids = [aws_subnet.main-private-1.id, aws_subnet.main-private-2.id]
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
        #security_groups = [aws_security_group.example.id]
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