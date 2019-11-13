resource "aws_sns_topic" "topic" {
  name = "csye6225_lambda_topic"
}

resource "aws_lambda_permission" "with_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.func.function_name}"
  principal     = "sns.amazonaws.com"
  source_arn    = "${aws_sns_topic.topic.arn}"
}


resource "aws_sns_topic_subscription" "lambda" {
  topic_arn = "${aws_sns_topic.topic.arn}"
#   delivery of JSON-encoded message to a lambda function
  protocol  = "lambda"
  endpoint  = "${aws_lambda_function.func.arn}" 
}


resource "aws_lambda_function" "func" {
  filename      = "/home/aman/terraform/lambdaFunction.zip"
  function_name = "lambda_called_from_sns"
  role          = "${aws_iam_role.lambda-sns-role.arn}"
#   handler is the function lambda calls to begin executing my function
  handler       = "handleRequest"
  runtime       = "java8"
#   amount of time Lambda Function has to run in seconds
  timeout       = "900"

#   environment {
#     variables = {
#       foo = "bar"
#     }
#   }
}


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
  description = "Policy for cloud watch and code deploy"
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

resource "aws_iam_role_policy_attachment" "CloudWatch_CodeDeployRole_policy_attach" {
  role       = "${aws_iam_role.lambda-sns-role.name}"
#   depends_on = ["aws_iam_role.lambda-sns-role"]
  policy_arn = "${aws_iam_policy.CloudWatch-CodeDeploy.arn}"
}


# resource "aws_launch_configuration" "config_for_auto_scaling" {
#   name                              = "asg_launch_config"
# # AMI
#   image_id                          = ""
#   instance_type                     = "t2.nano"
# #   YOUR_AWS_KEYNAME - Key Name that should be used for the instance
#   key_name                          = ""  
#   associate_public_ip_address       = "true"
#   user_data                         = "${templatefile("${path.module}/module1/user_data.sh",
#                                         {
#                                             s3_bucket_name  = "${aws_s3_bucket.my_s3_bucket.id}",
#                                             aws_db_endpoint = "${aws_db_instance.my_rds.endpoint}",
#                                             aws_db_name     = "${aws_db_instance.my_rds.name}",
#                                             aws_db_username = "${aws_db_instance.my_rds.username}",
#                                             aws_db_password = "${aws_db_instance.my_rds.password}",
#                                             aws_region      = "${var.region}",
#                                             aws_profile     = "${var.profile}"  
#                                         })}"
#   iam_instance_profile              = "${var.iam_instance_profile}"
# #    	Updated web security group.
#   security_groups                   = ""
# } 

# resource "aws_autoscaling_group" "auto_scale" {
#     name                            = "auto_scale"
#     default_cooldown                = "60"
#     launch_configuration            = "${aws_launch_configuration.config_for_auto_scaling.name}"
#     min_size                        = 1
#     max_size                        = 3
#     desired_capacity                = 3    

#     tags = [
#     {
#       key                 = "Name"
#       type                = "KEY_AND_VALUE"
#       value               = "EC2_for_web"
#     #   key                 = "Environment"
#     #   value               = "dev"
#       propagate_at_launch = true
#     }
#   ]
# }

# resource "aws_autoscaling_policy" "scale_up_policy" {
#   name                   = "scale_up_policy"
#   scaling_adjustment     = 1
#   adjustment_type        = "ChangeInCapacity"
#   cooldown               = 60
#   autoscaling_group_name = "${aws_autoscaling_group.auto_scale.name}"    

#   target_tracking_configuration {
#   customized_metric_specification {
#     metric_dimension {
#       name  = "AutoScale_ScaleUpPolicy"
#       value = "AutoScale_ScaleUpPolicy"
#     }

#     metric_name = "CPUUtilization"
#     namespace   = "AWS/EC2"
#     statistic   = "Average"
#     # unit        = 5
#     }
  
#   target_value = 5
#   }

# }

# resource "aws_autoscaling_policy" "scale_down_policy" {
#   name                   = "scale_down_policy"
#   scaling_adjustment     = "-1"
#   adjustment_type        = "ChangeInCapacity"
#   cooldown               = 60
#   autoscaling_group_name = "${aws_autoscaling_group.auto_scale.name}"    

#   target_tracking_configuration {
#   customized_metric_specification {
#     metric_dimension {
#       name  = "AutoScale_ScaleDownPolicy"
#       value = "AutoScale_ScaleDownPolicy"
#     }

#     metric_name = "CPUUtilization"
#     namespace   = "AWS/EC2"
#     statistic   = "Average"
#     # unit        = 3
#     }
  
#   target_value = 3
#   }

# }