# A role for Amazon Redshift 
resource "aws_iam_role" "redshift_role" {
  name = "redshift_role"
  
assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "redshift.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
tags = {
    tag-key = "redshift-role"
  }
}

resource "aws_iam_role_policy" "s3_full_access_policy" {
  name = "redshift_s3_policy"
  role = aws_iam_role.redshift_role.id

policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "AmazonRedshiftQueryEditor" {
  name = "QueryEditor"
  role = aws_iam_role.redshift_role.id

policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "redshift:GetClusterCredentials",
                "redshift:ListSchemas",
                "redshift:ListTables",
                "redshift:ListDatabases",
                "redshift:ExecuteQuery",
                "redshift:FetchResults",
                "redshift:CancelQuery",
                "redshift:DescribeClusters",
                "redshift:DescribeQuery",
                "redshift:DescribeTable",
                "redshift:ViewQueriesFromConsole",
                "redshift:DescribeSavedQueries",
                "redshift:CreateSavedQuery",
                "redshift:DeleteSavedQueries",
                "redshift:ModifySavedQuery"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "AmazonRedshiftReadAccessOnly" {
  name = "AmazonRedshiftReadAccessOnly"
  role = aws_iam_role.redshift_role.id

policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "redshift:Describe*",
                "redshift:ViewQueriesInConsole",
                "ec2:DescribeAccountAttributes",
                "ec2:DescribeAddresses",
                "ec2:DescribeAvailabilityZones",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeSubnets",
                "ec2:DescribeVpcs",
                "ec2:DescribeInternetGateways",
                "sns:Get*",
                "sns:List*",
                "cloudwatch:Describe*",
                "cloudwatch:List*",
                "cloudwatch:Get*"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
EOF
}