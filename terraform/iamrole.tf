# # A role for Amazon Redshift 
# resource "aws_iam_role" "redshift_role" {
#   name = "redshift_role"
  
# assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": "redshift.amazonaws.com"
#       },
#       "Effect": "Allow",
#       "Sid": ""
#     }
#   ]
# }
# EOF
# tags = {
#     tag-key = "redshift-role"
#   }
# }

# resource "aws_iam_role_policy" "s3_full_access_policy" {
#   name = "redshift_s3_policy"
#   role = aws_iam_role.redshift_role.id

# policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": "s3:*",
#             "Resource": "*"
#         }
#     ]
# }
# EOF
# }

# resource "aws_iam_role_policy" "AmazonRedshiftQueryEditor" {
#   name = "QueryEditor"
#   role = aws_iam_role.redshift_role.id

# policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "redshift:GetClusterCredentials",
#                 "redshift:ListSchemas",
#                 "redshift:ListTables",
#                 "redshift:ListDatabases",
#                 "redshift:ExecuteQuery",
#                 "redshift:FetchResults",
#                 "redshift:CancelQuery",
#                 "redshift:DescribeClusters",
#                 "redshift:DescribeQuery",
#                 "redshift:DescribeTable",
#                 "redshift:ViewQueriesFromConsole",
#                 "redshift:DescribeSavedQueries",
#                 "redshift:CreateSavedQuery",
#                 "redshift:DeleteSavedQueries",
#                 "redshift:ModifySavedQuery"
#             ],
#             "Resource": "*"
#         }
#     ]
# }
# EOF
# }

# resource "aws_iam_role_policy" "AmazonRedshiftReadAccessOnly" {
#   name = "AmazonRedshiftReadAccessOnly"
#   role = aws_iam_role.redshift_role.id

# policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Action": [
#                 "redshift:Describe*",
#                 "redshift:ViewQueriesInConsole",
#                 "ec2:DescribeAccountAttributes",
#                 "ec2:DescribeAddresses",
#                 "ec2:DescribeAvailabilityZones",
#                 "ec2:DescribeSecurityGroups",
#                 "ec2:DescribeSubnets",
#                 "ec2:DescribeVpcs",
#                 "ec2:DescribeInternetGateways",
#                 "sns:Get*",
#                 "sns:List*",
#                 "cloudwatch:Describe*",
#                 "cloudwatch:List*",
#                 "cloudwatch:Get*"
#             ],
#             "Effect": "Allow",
#             "Resource": "*"
#         }
#     ]
# }
# EOF
# }

resource "random_pet" "this" {}

resource "aws_iam_role" "this" {
  name               = "${title(var.name)}Role${title(random_pet.this.id)}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = var.tags
}

resource "aws_iam_instance_profile" "this" {
  name = "${title(var.name)}InstanceProfile${title(random_pet.this.id)}"
  role = aws_iam_role.this.name
}

resource "aws_iam_policy" "efs_mount_policy" {
  name   = "${var.name}EfsMountPolicy${title(random_pet.this.id)}"
  policy = <<-EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": "${aws_efs_file_system.this.arn}",
            "Action": [
                "elasticfilesystem:ClientMount",
                "elasticfilesystem:ClientWrite"
            ],
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "true"
                }
            }
        }
    ]
}
EOT
}

resource "aws_iam_role_policy_attachment" "ebs_mount_policy" {
  role       = aws_iam_role.this.id
  policy_arn = aws_iam_policy.efs_mount_policy.arn
}

data "aws_caller_identity" "this" {}

resource "aws_s3_bucket" "logs" {
  bucket = "airflow-logs-${data.aws_caller_identity.this.account_id}"
  acl    = "private"
  tags   = var.tags
}

resource "aws_iam_policy" "s3_put_logs_policy" {
  name   = "${var.name}S3PutLogsPolicy${title(random_pet.this.id)}"
  policy = <<-EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
          "Sid":"ReadWrite",
          "Effect":"Allow",
          "Action":["s3:GetObject", "s3:PutObject"],
          "Resource":["arn:aws:s3:::${aws_s3_bucket.logs.bucket}/*"]
        }
    ]
}

EOT
}

resource "aws_iam_role_policy_attachment" "s3_put_logs_policy" {
  role       = aws_iam_role.this.id
  policy_arn = aws_iam_policy.s3_put_logs_policy.arn
}