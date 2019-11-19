# resource "aws_iam_role_policy" "circleci-ec2-ami" {
#   name = "${var.name_ami_role_policy}"


# }

# resource "aws_iam_user" "circleci" {
#   name = "${var.iam_username}"
# }

# data "aws_caller_identity" "current" {}

# data "aws_region" "current" {}

resource "aws_iam_policy" "circleci-ec2-ami" {
  name        = "${var.iam_policy_name}"
  description = "${var.iam_policy_description}"
  policy      = <<EOF
{
  "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action" : [
          "ec2:AttachVolume",
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:CopyImage",
          "ec2:CreateImage",
          "ec2:CreateKeypair",
          "ec2:CreateSecurityGroup",
          "ec2:CreateSnapshot",
          "ec2:CreateTags",
          "ec2:CreateVolume",
          "ec2:DeleteKeyPair",
          "ec2:DeleteSecurityGroup",
          "ec2:DeleteSnapshot",
          "ec2:DeleteVolume",
          "ec2:DeregisterImage",
          "ec2:DescribeImageAttribute",
          "ec2:DescribeImages",
          "ec2:DescribeInstances",
          "ec2:DescribeInstanceStatus",
          "ec2:DescribeRegions",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSnapshots",
          "ec2:DescribeSubnets",
          "ec2:DescribeTags",
          "ec2:DescribeVolumes",
          "ec2:DetachVolume",
          "ec2:GetPasswordData",
          "ec2:ModifyImageAttribute",
          "ec2:ModifyInstanceAttribute",
          "ec2:ModifySnapshotAttribute",
          "ec2:RegisterImage",
          "ec2:RunInstances",
          "ec2:StopInstances",
          "ec2:TerminateInstances"
        ],
        "Resource" : "*"
     }
    ]
}
EOF
}

resource "aws_iam_user_policy_attachment" "attach-circleci-ec2-ami-user-policy" {
  user       = "${var.iam_username}"
  policy_arn = "${aws_iam_policy.circleci-ec2-ami.arn}"
}



# resource "aws_iam_user_policy_attachment" "attach-circleci-CodeDeploy-EC2-S3-user-policy" {
#   user       = "${var.iam_username}"
#   policy_arn = "${aws_iam_policy.CodeDeploy-EC2-S3.arn}"
# }


# # S3 bucket for codedeploy
# resource "aws_s3_bucket" "s3_bucket_codedeploy" {
#   bucket                = "${var.s3_bucket_codedeploy}"
#   acl                   = "${var.s3_acl}"  
#   force_destroy         = "${var.s3_force_destroy}"

#   server_side_encryption_configuration {
#     rule {
#       apply_server_side_encryption_by_default {
#         sse_algorithm     = "aws:kms"
#       }
#     }
#   }

#   tags = {
#     Name        = "${var.s3_bucket_name_codedeploy}"
#   }

#   lifecycle_rule {
#     id                    = "${var.s3_lifecycle_id_codedeploy}"
#     enabled               = "${var.s3_lifecycle_enabled}"
#     # prefix                = "${var.s3_lifecycle_prefix}"

#     transition {
#       days                = "${var.s3_lifecycle_transition_days_codedeploy}"
#       storage_class       = "${var.s3_lifecycle_transition_storage_class}"
#     }
#   }
# }

data "aws_s3_bucket" "codedeploy_bucket" {
  bucket = "${var.codeDeployBucket}"
}



# to put revision in an s3 bucket
resource "aws_iam_policy" "CircleCI-Upload-To-S3" {
  name        = "${var.CircleCI_Upload_To_S3_policy_name}"
  description = "${var.CircleCI_Upload_To_S3_policy_description}"
  depends_on  = ["data.aws_s3_bucket.codedeploy_bucket"]
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Sid": "AllowGetPutDeleteActionsOnS3Bucket",
          "Effect": "Allow",
          "Action": ["s3:PutObject"],
          "Resource": [
            "arn:aws:s3:::${var.codeDeployBucket}",
            "arn:aws:s3:::${var.codeDeployBucket}/*"  
          ]
      }
  ]
}
EOF
}


resource "aws_iam_user_policy_attachment" "attach-circleci-CircleCI-Upload-To-S3-user-policy" {
  user       = "${var.iam_username}"
  policy_arn = "${aws_iam_policy.CircleCI-Upload-To-S3.arn}"
}


# Allow circleci user to call code deploy
resource "aws_iam_policy" "CircleCI-Code-Deploy" {
  name          = "${var.CircleCI_Code_Deploy_policy_name}"
  description   = "${var.CircleCI_Code_Deploy_policy_description}"
  policy        = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "codedeploy:RegisterApplicationRevision",
        "codedeploy:GetApplicationRevision"
      ],
      "Resource": [
        "arn:aws:codedeploy:${var.region}:${var.account_id}:application:${var.application_name}"
      ]
    },  
    {
      "Effect": "Allow",
      "Action": [
        "codedeploy:CreateDeployment",
        "codedeploy:GetDeployment"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "codedeploy:GetDeploymentConfig"
      ],
      "Resource": [
        "arn:aws:codedeploy:${var.region}:${var.account_id}:deploymentconfig:CodeDeployDefault.OneAtATime",
        "arn:aws:codedeploy:${var.region}:${var.account_id}:deploymentconfig:CodeDeployDefault.HalfAtATime",
        "arn:aws:codedeploy:${var.region}:${var.account_id}:deploymentconfig:CodeDeployDefault.AllAtOnce"
      ]
    }
  ]
}
  EOF
}


resource "aws_iam_user_policy_attachment" "attach-circleci-CircleCI-Code-Deploy-user-policy" {
  user       = "${var.iam_username}"
  policy_arn = "${aws_iam_policy.CircleCI-Code-Deploy.arn}"
}


# resource "aws_codedeploy_app" "csye6225-webapp" {
#   compute_platform = "Server"
#   name             = "${var.application_name}"
# }

# resource "aws_codedeploy_deployment_group" "csye6225-webapp-deployment" {
#   app_name              = "${aws_codedeploy_app.csye6225-webapp.name}"
#   deployment_group_name = "csye6225-webapp-deployment"
#   # service_role_arn      = "${aws_iam_role.CodeDeployServiceRole.arn}"
#   service_role_arn      = "arn:aws:iam::${var.account_id}:role/CodeDeployServiceRole"
#   deployment_config_name = "CodeDeployDefault.AllAtOnce"

#   deployment_style {
#     deployment_option = "WITHOUT_TRAFFIC_CONTROL"
#     deployment_type   = "IN_PLACE"
#   }

#   ec2_tag_set {
#     ec2_tag_filter {
#       key   = "Name"
#       type  = "KEY_AND_VALUE"
#       value = "EC2_for_web"
#     }
#   }

#   auto_rollback_configuration {
#     enabled = true
#     events  = ["DEPLOYMENT_FAILURE"]
#   }

#   # autoscaling_groups = ["${aws_autoscaling_group.auto_scale.name}"]
#   # load_balancer_info{
#   #   # yet to be completed
#   # }

# }     

# # Roles that allow ec2 instances/other aws services to call other aws services on my behalf

# # Role to allow code deploy to call aws services on my behalf
resource "aws_iam_role" "CodeDeployServiceRole" {
  name = "CodeDeployServiceRole"
  path = "/"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "codedeploy.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
}
EOF
    tags = {
      Name = "CodeDeployServiceRole"
    }
}

resource "aws_iam_role_policy_attachment" "CodeDeployServiceRole_policy_attach" {
  role       = "${aws_iam_role.CodeDeployServiceRole.name}"
  depends_on = ["aws_iam_role.CodeDeployServiceRole"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}


# allow ec2 to download revisions from s3 bucket
resource "aws_iam_policy" "CodeDeploy-EC2-S3" {
  name        = "${var.CodeDeploy_EC2_S3_policy_name}"
  description = "${var.CodeDeploy_EC2_S3_policy_description}"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:Get*",
                "s3:List*"
            ],
            "Effect": "Allow",
            "Resource": ["arn:aws:s3:::${var.codeDeployBucket}", 
                          "arn:aws:s3:::${var.codeDeployBucket}/*", 
                         "arn:aws:s3:::aws-codedeploy-us-east-2/*",
                         "arn:aws:s3:::aws-codedeploy-us-east-1/*"]
        }
    ]
}
  EOF
}


resource "aws_iam_role" "CodeDeployEC2ServiceRole" {
  name = "CodeDeployEC2ServiceRole"
  path = "/"
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
    tags = {
      Name = "CodeDeployEC2ServiceRole"
    }
}

resource "aws_iam_instance_profile" "test_profile" {
  name = "test_profile"
  role = "${aws_iam_role.CodeDeployEC2ServiceRole.name}"
}


# resource "aws_iam_role_policy" "CodeDeploy-EC2-S3" {
#   name    = "${var.CodeDeploy_EC2_S3_policy_name}"
#   role    = "${aws_iam_role.CodeDeployEC2ServiceRole.id}"
#   policy      = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Action": [
#                 "s3:Get*",
#                 "s3:List*"
#             ],
#             "Effect": "Allow",
#             "Resource": ["arn:aws:s3:::${var.codeDeployBucket}, 
#                           "arn:aws:s3:::${var.codeDeployBucket}/*",
#                          "arn:aws:s3:::aws-codedeploy-us-east-2/*",
#                          "arn:aws:s3:::aws-codedeploy-us-east-1/*"]
#         }
#     ]
# }
#   EOF
# }



resource "aws_iam_role_policy_attachment" "CodeDeployEC2ServiceRole_policy_attach" {
  role       = "${aws_iam_role.CodeDeployEC2ServiceRole.name}"
  depends_on = ["aws_iam_role.CodeDeployEC2ServiceRole"]
  policy_arn = "${aws_iam_policy.CodeDeploy-EC2-S3.arn}"
}

resource "aws_iam_role_policy_attachment" "CodeDeployEC2ServiceRole_CloudWatch_policy_attach" {
  role       = "${aws_iam_role.CodeDeployEC2ServiceRole.name}"
  depends_on = ["aws_iam_role.CodeDeployEC2ServiceRole"]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}


# output "aws_instance_profile_role" {
#   # value = "${aws_iam_instance_profile.test_profile.name}"
#   value = "${var.iam_instance_profile}"
# }

resource "aws_iam_role" "lambda-sns-role" {
  name = "role_for_lambda_with_sns"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda_policy"
  description = "Policies required by lambda"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:Get*",
                "s3:List*"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
          "Effect": "Allow",
          "Action": [
              "dynamodb:GetItem",
              "dynamodb:GetRecords",
              "dynamodb:DescribeTimeToLive",
              "dynamodb:ListStreams",
              "dynamodb:PutItem",
              "dynamodb:Query",
              "dynamodb:Scan",
              "dynamodb:UpdateItem",
              "dynamodb:UpdateTable",
              "dynamodb:UpdateTimeToLive",
              "dynamodb:DeleteItem"
          ],
          "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
              "ses:SendEmail",
              "ses:SendRawEmail"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        },
        {
          "Sid": "LambdaDynamoDBAccess",
          "Effect": "Allow",
          "Action": [
              "dynamodb:GetItem",
              "dynamodb:PutItem",
              "dynamodb:UpdateItem"
          ],
          "Resource": "*"  
        },
        {
          "Sid": "LambdaSESAccess",
          "Effect": "Allow",
          "Action": [
              "ses:VerifyEmailAddress",
              "ses:SendEmail",
              "ses:SendRawEmail"
          ],
          "Resource": "*"   
        },
        {
          "Sid": "LambdaS3Access",
          "Effect": "Allow",
          "Action": [
              "s3:GetObject"
          ],
          "Resource": "*"
        },
        {
          "Sid": "LambdaSNSAccess",
          "Effect": "Allow",
          "Action": [
              "sns:ConfirmSubscription"
          ],
          "Resource": "*"
        }
    ]
}
  EOF
}

resource "aws_iam_role_policy_attachment" "lambda_policy_policy_attach" {
  role       = "${aws_iam_role.lambda-sns-role.name}"
#   depends_on = ["aws_iam_role.lambda-sns-role"]
  policy_arn = "${aws_iam_policy.lambda_policy.arn}"
}