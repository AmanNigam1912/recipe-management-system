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
  filename      = "/home/aman/terraform/Email-1.0-SNAPSHOT.jar"
  function_name = "lambda_called_from_sns"
  role          = "${aws_iam_role.lambda-sns-role.arn}"
#   handler is the function lambda calls to begin executing my function
  handler       = "Email::handleRequest"
  runtime       = "java8"
#   amount of time Lambda Function has to run in seconds
  timeout       = 900
  memory_size   = 256

  environment {
    variables = {
      domain = "${var.domain}"
    }
  }
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


# resource "aws_security_group" "lc_sg" {
#   name              = "lc_sg"
#   description       = "Security Group for launch configuration"

#   ingress {
#     from_port       = 20 
#     to_port         = 20   
#     protocol        = "${var.aws_security_group_protocol}"
#     cidr_blocks     = ["0.0.0.0/0"]
#     #cidr_blocks values??
#   }

#   ingress {
#     from_port       = 8080 
#     to_port         = 8080  
#     protocol        = "${var.aws_security_group_protocol}"
#     cidr_blocks     = ["0.0.0.0/0"]
#   }

#   # egress {
#   #   from_port       = 8080 
#   #   to_port         = 8080  
#   #   protocol        = "${var.aws_security_group_protocol}"
#   #   cidr_blocks     = ["0.0.0.0/0"]
#   # }

# }

# resource "aws_launch_configuration" "config_for_auto_scaling" {
#   name                              = "asg_launch_config"
# # AMI
#   image_id                          = "${var.ami}"
#   instance_type                     = "t2.nano"
# #   YOUR_AWS_KEYNAME - Key Name that should be used for the instance
#   key_name                          = "${var.key_name}"  
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
#   security_groups                   = "${aws_security_group.lc_sg.name}"
# } 

# resource "aws_autoscaling_group" "auto_scale" {
#     name                            = "auto_scale"
#     default_cooldown                = "60"
#     launch_configuration            = "${aws_launch_configuration.config_for_auto_scaling.name}"
#     min_size                        = "1"
#     max_size                        = "3"
#     desired_capacity                = "3"    

#     tags = [
#     {
#       key                 = "Name"
#       type                = "KEY_AND_VALUE"
#       value               = "EC2_for_web"
#     #   key                 = "Environment"
#     #   value               = "dev"
#       propagate_at_launch = "true"
#     }
#   ]
# }

# resource "aws_autoscaling_policy" "scale_up_policy" {
#   name                   = "scale_up_policy"
#   scaling_adjustment     = "1"
#   adjustment_type        = "ChangeInCapacity"
#   cooldown               = "60"
#   autoscaling_group_name = "${aws_autoscaling_group.auto_scale.name}"    

#   target_tracking_configuration {
#   # customized_metric_specification {
#   #   metric_dimension {
#   #     name  = "AutoScale_ScaleUpPolicy"
#   #     value = "AutoScale_ScaleUpPolicy"
#   #   }

#   #   metric_name = "CPUUtilization"
#   #   namespace   = "AWS/EC2"
#   #   statistic   = "Average"
#   #   # unit        = 5
#   #   }

#   predefined_metric_specification {
#     predefined_metric_type = "ASGAverageCPUUtilization"
#   }  
#   target_value = "5"
#   }

# }

# resource "aws_autoscaling_policy" "scale_down_policy" {
#   name                   = "scale_down_policy"
#   scaling_adjustment     = "-1"
#   adjustment_type        = "ChangeInCapacity"
#   cooldown               = "60"
#   autoscaling_group_name = "${aws_autoscaling_group.auto_scale.name}"    

#   target_tracking_configuration {
#   # customized_metric_specification {
#   #   metric_dimension {
#   #     name  = "AutoScale_ScaleDownPolicy"
#   #     value = "AutoScale_ScaleDownPolicy"
#   #   }

#   #   metric_name = "CPUUtilization"
#   #   namespace   = "AWS/EC2"
#   #   statistic   = "Average"
#   #   # unit        = 3
#   #   }
  
#   predefined_metric_specification {
#     predefined_metric_type = "ASGAverageCPUUtilization"
#   }  
#   target_value = 3
#   }

# }