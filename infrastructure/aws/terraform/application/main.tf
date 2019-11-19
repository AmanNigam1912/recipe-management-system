
resource "aws_security_group" "application" {
  name              = "${var.SGApplication}"
  description       = "Security Group to host web application"
  vpc_id            = "${var.vpc_id}"


  ingress {
    from_port       = 22 
    to_port         = 22   
    protocol        = "${var.aws_security_group_protocol}"
    cidr_blocks     = ["0.0.0.0/0"]
    #cidr_blocks values??
  }

  ingress {
    from_port       = 80 
    to_port         = 80   
    protocol        = "${var.aws_security_group_protocol}"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  # egress {
  #   from_port       = 80
  #   to_port         = 80   
  #   protocol        = "${var.aws_security_group_protocol}"
  #   cidr_blocks     = ["0.0.0.0/0"]
  # }

  # egress {
  #   from_port       = 443 
  #   to_port         = 443  
  #   protocol        = "${var.aws_security_group_protocol}"
  #   cidr_blocks     = ["0.0.0.0/0"]
  # }
  # HTTPS 
  ingress {
    from_port       = 443 
    to_port         = 443  
    protocol        = "${var.aws_security_group_protocol}"
    security_groups = ["${aws_security_group.load_balancer_sg.id}"]
    cidr_blocks     = ["0.0.0.0/0"]
  }

  # ingress {
  #   from_port       = 8080 
  #   to_port         = 8080  
  #   protocol        = "${var.aws_security_group_protocol}"
  #   cidr_blocks     = ["0.0.0.0/0"]
  # }

  ingress {
    from_port       = 8080 
    to_port         = 8080  
    protocol        = "${var.aws_security_group_protocol}"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  # ingress {
  #   from_port       = 32768
  #   to_port         = 65535
  #   protocol        = "${var.aws_security_group_protocol}"
  #   cidr_blocks     = ["0.0.0.0/0"]
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # egress {
  #   from_port       = 80
  #   to_port         = 80   
  #   protocol        = "${var.aws_security_group_protocol}"
  #   cidr_blocks     = ["0.0.0.0/0"]
  # }

  # egress {
  #   from_port       = 443 
  #   to_port         = 443  
  #   protocol        = "${var.aws_security_group_protocol}"
  #   cidr_blocks     = ["0.0.0.0/0"]
  # }

  # egress {
  #   from_port       = 32768
  #   to_port         = 65535
  #   protocol        = "${var.aws_security_group_protocol}"
  #   cidr_blocks     = ["0.0.0.0/0"]
  # }

  # ingress {
  #   from_port       = 22 
  #   to_port         = 22   
  #   protocol        = "${var.aws_security_group_protocol}"
  #   cidr_blocks     = ["0.0.0.0/0"]
  #   #cidr_blocks values??
  # }
}


# resource "aws_security_group_rule" "application" {
#     from_port                     = 8080
#     to_port                       = 8080
#     protocol                      = "${var.aws_security_group_protocol}"
#     type                          = "ingress"
#     source_security_group_id      = "${aws_security_group.load_balancer_sg.id}"
#     security_group_id             = "${aws_security_group.application.id}"          
# }


resource "aws_security_group" "database" {
  name              = "${var.SGDatabase}"
  description       = "Security Group for database"
  vpc_id            = "${var.vpc_id}"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "${var.aws_security_group_protocol}"
    security_groups = ["${aws_security_group.application.id}"]
  }
}

resource "aws_security_group" "load_balancer_sg" {
  name              = "load_balancer_sg"
  description       = "Security group for load balancer"
  vpc_id            = "${var.vpc_id}"

  ingress {
    from_port       = 22 
    to_port         = 22   
    protocol        = "${var.aws_security_group_protocol}"
    cidr_blocks     = ["0.0.0.0/0"]
    #cidr_blocks values??
  }

  ingress {
    from_port       = 80 
    to_port         = 80   
    protocol        = "${var.aws_security_group_protocol}"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  # HTTPS
  ingress {
    from_port       = 443 
    to_port         = 443  
    protocol        = "${var.aws_security_group_protocol}"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 8080 
    to_port         = 8080  
    protocol        = "${var.aws_security_group_protocol}"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  # ingress {
  #   from_port       = 32768
  #   to_port         = 65535
  #   protocol        = "${var.aws_security_group_protocol}"
  #   cidr_blocks     = ["0.0.0.0/0"]
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # egress {
  #   from_port       = 80
  #   to_port         = 80   
  #   protocol        = "${var.aws_security_group_protocol}"
  #   cidr_blocks     = ["0.0.0.0/0"]
  # }

  # egress {
  #   from_port       = 443 
  #   to_port         = 443  
  #   protocol        = "${var.aws_security_group_protocol}"
  #   cidr_blocks     = ["0.0.0.0/0"]
  # }

  # egress {
  #   from_port       = 32768
  #   to_port         = 65535
  #   protocol        = "${var.aws_security_group_protocol}"
  #   cidr_blocks     = ["0.0.0.0/0"]
  # }  
}

# data "aws_subnet_ids" "vpc" {
#   vpc_id = "${var.vpc_id}"
# }

# data "aws_subnet" "subnet1" {
#   count = "${length(data.aws_subnet_ids.vpc.ids)}"
#   id    = "${data.aws_subnet_ids.vpc.ids[count.index]}"
# }

# data "aws_subnet" "subnet2" {
#   count = "${length(data.aws_subnet_ids.vpc.ids)}"
#   id    = "${data.aws_subnet_ids.vpc.ids[count.index]}"
# }
resource "aws_db_subnet_group" "rds-subnet" {
  # count             = "${var.subnetCount}"
  name              = "${var.rds_subnet_group_name}"
  # subnet_ids        = "${element(data.aws_subnet_ids.private.ids, 1)}"
  subnet_ids        =  ["${element(tolist(data.aws_subnet_ids.subnet.ids), 0)}","${element(tolist(data.aws_subnet_ids.subnet.ids), 1)}"]
  # subnet_ids          = ["${var.rds_subnet1}","${var.rds_subnet2}"]
  #rds_subnet_id1 and rds_subnet_id2 not yet defined
}

# resource "aws_security_group_rule" "database_rule" {
#   from_port                     = 3306
#   to_port                       = 3306
#   protocol                      = "${var.aws_security_group_protocol}"
#   type                          = "ingress"
#   source_security_group_id      = "${aws_security_group.application.id}"
#   security_group_id             = "${aws_security_group.database.id}"
#   # cidr_blocks         = ["10.0.1.0/24"]
# }

resource "aws_db_instance" "my_rds" {
  name                  = "${var.db_name}"
  allocated_storage     = "${var.db_allocated_storage}"
  storage_type          = "${var.db_storage_type}"
  engine                = "${var.db_engine}"
  engine_version        = "${var.db_engine_version}"
  instance_class        = "${var.db_instance}"
  multi_az              = "${var.db_multi_az}"
  identifier            = "${var.db_identifier}"
  username              = "${var.db_username}"
  password              = "${var.db_password}"
  db_subnet_group_name  = "${aws_db_subnet_group.rds-subnet.name}"
  publicly_accessible   = "${var.db_publicly_accessible}"
  vpc_security_group_ids= ["${aws_security_group.database.id}"]  
  skip_final_snapshot   = "${var.db_skip_final_snapshot}"
}

resource "aws_s3_bucket" "my_s3_bucket" {
  bucket                = "${var.s3_bucket}"
  acl                   = "${var.s3_acl}"  
  force_destroy         = "${var.s3_force_destroy}"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = {
    Name        = "${var.s3_bucket_name}"
  }

  lifecycle_rule {
    id                    = "${var.s3_lifecycle_id}"
    enabled               = "${var.s3_lifecycle_enabled}"
    # prefix                = "${var.s3_lifecycle_prefix}"

    transition {
      days                = "${var.s3_lifecycle_transition_days}"
      storage_class       = "${var.s3_lifecycle_transition_storage_class}"
    }
  }
}

data "aws_availability_zones" "available" {
    state = "available" 
}

data "aws_subnet_ids" "subnet" {
    vpc_id = "${var.vpc_id}"
}


# resource "aws_instance" "ec2_instance" {
#   ami                       = "${var.ami}"
#   instance_type             = "${var.instance_type}"
#   disable_api_termination   = "${var.disable_api_termination}"
#   availability_zone         = "${data.aws_availability_zones.available.names[1]}"
#   key_name                  = "${var.key_name}"
#   # iam_instance_profile      = "${aws_iam_role_policy_attachment.CodeDeployEC2ServiceRole_s3Bucket_CRUD_policy_attach.role}"
#   iam_instance_profile      = "${var.iam_instance_profile}"

#   ebs_block_device {
#     device_name               = "${var.device_name}"
#     volume_size               = "${var.volume_size}"
#     volume_type               = "${var.volume_type}"
#     # delete_on_termination     = "${var.delete_on_termination}"
#     delete_on_termination     = "${var.delete_on_termination}"
#   }

#   tags = {
#     Name = "EC2_for_web"
#   }

#   vpc_security_group_ids      = ["${aws_security_group.application.id}"]
#   associate_public_ip_address = true
#   source_dest_check           = false
#   subnet_id                   = "${element(tolist(data.aws_subnet_ids.subnet.ids), 0)}"
#   depends_on                  = [aws_db_instance.my_rds,aws_s3_bucket.my_s3_bucket]
#   user_data                   = "${templatefile("${path.module}/module1/user_data.sh",
#                                       {
#                                         s3_bucket_name  = "${aws_s3_bucket.my_s3_bucket.id}",
#                                         aws_db_endpoint = "${aws_db_instance.my_rds.endpoint}",
#                                         aws_db_name     = "${aws_db_instance.my_rds.name}",
#                                         aws_db_username = "${aws_db_instance.my_rds.username}",
#                                         aws_db_password = "${aws_db_instance.my_rds.password}",
#                                         aws_region      = "${var.region}",
#                                         aws_profile     = "${var.profile}"
#                                         # ,aws_snsTopic    = "${var.snsTopic}"  
#                                       })}"
# }

resource "aws_dynamodb_table" "dynamoDB_Table" {
  name                        = "${var.dynamoDB_name}"
  hash_key                    = "${var.dynamoDB_hashKey}"
  write_capacity              = "${var.dynamoDB_writeCapacity}"
  read_capacity               = "${var.dynamoDB_readCapacity}"
  ttl {
    attribute_name = "timeStamp"
    enabled        = true
  }

  attribute {
    name = "${var.dynamoDB_hashKey}"
    type = "S"
  }
}


resource "aws_iam_policy" "s3Bucket-CRUD-Policy" {
  name        = "s3Bucket-CRUD-Policy"
  description = "A Upload policy"
  depends_on = ["aws_s3_bucket.my_s3_bucket"]
  policy = <<EOF
{
          "Version" : "2012-10-17",
          "Statement": [
            {
              "Sid": "AllowGetPutDeleteActionsOnS3Bucket",
              "Effect": "Allow",
              "Action": ["s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject",
                "s3:GetBucketAcl",
                "s3:GetObjectAcl",
                "s3:GetObjectVersionAcl",
                "s3:ListAllMyBuckets",
                "s3:ListBucket"],
              "Resource": ["${aws_s3_bucket.my_s3_bucket.arn}","${aws_s3_bucket.my_s3_bucket.arn}/*"]
            }
          ]
        }
EOF
}

resource "aws_iam_role_policy_attachment" "CodeDeployEC2ServiceRole_s3Bucket_CRUD_policy_attach" {
  role       = "CodeDeployEC2ServiceRole"
  # depends_on = ["aws_iam_role.CodeDeployEC2ServiceRole"]
  policy_arn = "${aws_iam_policy.s3Bucket-CRUD-Policy.arn}"
}


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
  role          = "arn:aws:iam::${var.account_id}:role/${var.lambda_role}"
#   handler is the function lambda calls to begin executing my function
  handler       = "Email::handleRequest"
  runtime       = "java8"
#   amount of time Lambda Function has to run in seconds
  timeout       = 900
  memory_size   = 256

  environment {
    variables = {
      domainName = "${var.domain}"
      timeToLive = "${var.timeToLive}"
    }
  }
}


# # resource "aws_security_group" "lc_sg" {
# #   name              = "lc_sg"
# #   description       = "Security Group for launch configuration"
# #   vpc_id            = "${var.vpc_id}"
# #   ingress {
# #     from_port       = 20 
# #     to_port         = 20   
# #     protocol        = "${var.aws_security_group_protocol}"
# #     cidr_blocks     = ["0.0.0.0/0"]
# #     #cidr_blocks values??
# #   }

# #   ingress {
# #     from_port       = 8080 
# #     to_port         = 8080  
# #     protocol        = "${var.aws_security_group_protocol}"
# #     cidr_blocks     = ["0.0.0.0/0"]
# #   }

# #   # egress {
# #   #   from_port       = 8080 
# #   #   to_port         = 8080  
# #   #   protocol        = "${var.aws_security_group_protocol}"
# #   #   cidr_blocks     = ["0.0.0.0/0"]
# #   # }

# # }


resource "aws_codedeploy_app" "csye6225-webapp" {
  compute_platform = "Server"
  name             = "${var.application_name}"
}

resource "aws_codedeploy_deployment_group" "csye6225-webapp-deployment" {
  app_name              = "${aws_codedeploy_app.csye6225-webapp.name}"
  deployment_group_name = "csye6225-webapp-deployment"
  # service_role_arn      = "${aws_iam_role.CodeDeployServiceRole.arn}"
  service_role_arn      = "arn:aws:iam::${var.account_id}:role/CodeDeployServiceRole"
  deployment_config_name = "CodeDeployDefault.AllAtOnce"

  deployment_style {
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = "EC2_for_web"
    }
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  # autoscaling_groups = ["${aws_autoscaling_group.auto_scale.name}"]
  # load_balancer_info{
  #   # yet to be completed
  # }
  load_balancer_info {
    target_group_info {
        name  = "${aws_lb_target_group.auto_scale_target_group.name}"
    }
  }
  autoscaling_groups = ["${aws_autoscaling_group.auto_scale.name}"]

}     

resource "aws_launch_configuration" "config_for_auto_scaling" {
  # name                              = "asg_launch_config"
  name_prefix                         = "asg-launch-config" 
# AMI
  image_id                          = "${var.ami}"
  instance_type                     = "t2.micro"
#   YOUR_AWS_KEYNAME - Key Name that should be used for the instance
  key_name                          = "${var.key_name}"  
  associate_public_ip_address       = true
  user_data                         = "${templatefile("${path.module}/module1/user_data.sh",
                                      {
                                        s3_bucket_name  = "${aws_s3_bucket.my_s3_bucket.id}",
                                        aws_db_endpoint = "${aws_db_instance.my_rds.endpoint}",
                                        aws_db_name     = "${aws_db_instance.my_rds.name}",
                                        aws_db_username = "${aws_db_instance.my_rds.username}",
                                        aws_db_password = "${aws_db_instance.my_rds.password}",
                                        aws_region      = "${var.region}",
                                        aws_profile     = "${var.profile}"
                                        # ,aws_snsTopic    = "${var.snsTopic}"  
                                      })}"
  iam_instance_profile              = "${var.iam_instance_profile}"
#    	Updated web security group.
  security_groups                   = ["${aws_security_group.application.id}"]
  lifecycle {
    create_before_destroy = true
  }

  ebs_block_device {
    device_name               = "${var.device_name}"
    volume_size               = "${var.volume_size}"
    volume_type               = "${var.volume_type}"
    # delete_on_termination     = "${var.delete_on_termination}"
    delete_on_termination     = "${var.delete_on_termination}"
  }
} 

resource "aws_autoscaling_group" "auto_scale" {
    name                            = "auto_scale"
    default_cooldown                = "60"
    launch_configuration            = "${aws_launch_configuration.config_for_auto_scaling.name}"
    min_size                        = "3"
    max_size                        = "5"
    desired_capacity                = "3"    
    # availability_zones              = ["${data.aws_availability_zones.available.names[0]}","${data.aws_availability_zones.available.names[1]}","${data.aws_availability_zones.available.names[2]}"]
    vpc_zone_identifier             = ["${element(tolist(data.aws_subnet_ids.subnet.ids), 0)}","${element(tolist(data.aws_subnet_ids.subnet.ids), 1)}","${element(tolist(data.aws_subnet_ids.subnet.ids), 2)}"]
    # health_check_type               = "ELB"
    target_group_arns               = ["${aws_lb_target_group.auto_scale_target_group.arn}"]
    force_delete                    = true

  #   lifecycle {
  #   create_before_destroy = true
  # }

    tag {
      key                 = "Name"
      value               = "EC2_for_web"
      propagate_at_launch = "true"
    }
  

  depends_on = ["aws_launch_configuration.config_for_auto_scaling", 
                "aws_lb_target_group.auto_scale_target_group",
                "aws_lb_listener.application_listener",
                "aws_lb_listener.http_listener"]
}



resource "aws_lb_target_group" "auto_scale_target_group" {
  name     = "auto-scale-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
  health_check {
    interval            = 30
    path                = "/Recipe_Management_System/healthCheck"
    protocol            = "HTTP"
    port                = 8080
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 5
    # matcher             = "200,302"
  }
  # tags {
  #   Name        = "dev-target-group"
  #   Owner       = "Tech-Overlord"
  #   Environment = "dev"
  # }
}








resource "aws_autoscaling_policy" "scale_up_policy" {
  name                   = "scale_up_policy"
  scaling_adjustment     = "1"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = "60"
  autoscaling_group_name = "${aws_autoscaling_group.auto_scale.name}"    

  # target_tracking_configuration {
  # # customized_metric_specification {
  # #   metric_dimension {
  # #     name  = "AutoScale_ScaleUpPolicy"
  # #     value = "AutoScale_ScaleUpPolicy"
  # #   }

  # #   metric_name = "CPUUtilization"
  # #   namespace   = "AWS/EC2"
  # #   statistic   = "Average"
  # #   # unit        = 5
  # #   }

  # predefined_metric_specification {
  #   predefined_metric_type = "ASGAverageCPUUtilization"
  # }  
  # target_value = "5"
  # }

}

resource "aws_autoscaling_policy" "scale_down_policy" {
  name                   = "scale_down_policy"
  scaling_adjustment     = "-1"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = "60"
  autoscaling_group_name = "${aws_autoscaling_group.auto_scale.name}"    

  # target_tracking_configuration {
  # # customized_metric_specification {
  # #   metric_dimension {
  # #     name  = "AutoScale_ScaleDownPolicy"
  # #     value = "AutoScale_ScaleDownPolicy"
  # #   }

  # #   metric_name = "CPUUtilization"
  # #   namespace   = "AWS/EC2"
  # #   statistic   = "Average"
  # #   # unit        = 3
  # #   }
  
  # predefined_metric_specification {
  #   predefined_metric_type = "ASGAverageCPUUtilization"
  # }  
  # target_value = 3
  # }

}

resource "aws_cloudwatch_metric_alarm" "CPUAlarmHigh" {
  alarm_name          = "CPUAlarmHigh"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "90"
  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.auto_scale.name}"
  }
  alarm_description   = "Monitor EC2 cpu utilization"
  alarm_actions       = ["${aws_autoscaling_policy.scale_up_policy.arn}"]
}


resource "aws_cloudwatch_metric_alarm" "CPUAlarmLow" {
  alarm_name          = "CPUAlarmLow"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "70"
  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.auto_scale.name}"
  }
  alarm_description   = "Monitor EC2 cpu utilization"
  alarm_actions       = ["${aws_autoscaling_policy.scale_down_policy.arn}"]
}


resource "aws_lb" "application_lb" {
  name               = "application-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.load_balancer_sg.id}"]
  subnets            = ["${element(tolist(data.aws_subnet_ids.subnet.ids), 0)}","${element(tolist(data.aws_subnet_ids.subnet.ids), 1)}","${element(tolist(data.aws_subnet_ids.subnet.ids), 2)}"]
  ip_address_type    = "ipv4"
# If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false.
  enable_deletion_protection = false

  # access_logs {
  #   bucket  = "${aws_s3_bucket.lb_logs.bucket}"
  #   prefix  = "test-lb"
  #   enabled = true
  # }

  # tags = {
  #   Environment = "production"
  # }
}


data "aws_acm_certificate" "ssl_certificate" {
  domain   = "dev.recipebyaman.me"
  statuses = ["ISSUED"]
}


resource "aws_lb_listener" "application_listener" {
  load_balancer_arn = "${aws_lb.application_lb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${data.aws_acm_certificate.ssl_certificate.arn}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.auto_scale_target_group.arn}"
  }
}


resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = "${aws_lb.application_lb.arn}"
  port              = "80"
  protocol          = "HTTP"
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = "${data.aws_acm_certificate.ssl_certificate.arn}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.auto_scale_target_group.arn}"
  }
}



# # resource "aws_elb" "instance_lb" {
# #   name               = "instance-lb"
# #   availability_zones = ["${data.aws_availability_zones.available.names[0]}","${data.aws_availability_zones.available.names[1]}","${data.aws_availability_zones.available.names[2]}"]

# #   # access_logs {
# #   #   bucket        = "foo"
# #   #   bucket_prefix = "bar"
# #   #   interval      = 60
# #   # }

# #   listener {
# #     instance_port     = 8000
# #     instance_protocol = "http"
# #     lb_port           = 80
# #     lb_protocol       = "http"
# #   }

# #   listener {
# #     instance_port      = 8000
# #     instance_protocol  = "http"
# #     lb_port            = 443
# #     lb_protocol        = "https"
# #     # ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
# #   }

# #   health_check {
# #     healthy_threshold   = 3
# #     unhealthy_threshold = 5
# #     timeout             = 5
# #     # Path for target
# #     target              = "HTTPS:8080/"
# #     interval            = 60
# #   }

# #   # instances                   = ["${aws_instance.foo.id}"]
# #   cross_zone_load_balancing   = true
# #   # idle_timeout                = 400
# #   # connection_draining         = true
# #   # connection_draining_timeout = 400

# #   # tags = {
# #   #   Name = "foobar-terraform-elb"
# #   # }
# # }


data "aws_route53_zone" "selected" {
  name         = "dev.recipebyaman.me"
  private_zone = false
}

resource "aws_route53_record" "www" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "${data.aws_route53_zone.selected.name}"
  type    = "A"

  alias {
    name                   = "${aws_lb.application_lb.dns_name}"
    zone_id                = "${aws_lb.application_lb.zone_id}"
    evaluate_target_health = false
  }
  # depends_on               = ["aws_lb.application_lb"] 
}



# resource "aws_cloudformation_stack" "waf" {
#   name = "waf-stack"

#   parameters = {
#     ALBArn = "${aws_lb.application_lb.arn}"
#   }

#   template_body = <<STACK
#   {
#     "AWSTemplateFormatVersion": "2010-09-09",
#     "Description": "Cloud Formation Template - CSYE6225 - Creating WAF Rules",
#     "Parameters": {
#         "IPtoBlock1": {
#             "Description": "IPAddress to be blocked",
#             "Default": "155.33.133.6/32",
#             "Type": "String"
#         },
#         "IPtoBlock2": {
#             "Description": "IPAddress to be blocked",
#             "Default": "192.0.7.0/24",
#             "Type": "String"
#         },
#         "ALBArn": {
#             "Description": "IPAddress to be blocked",
#             "Type": "String"
#         }
#     },
#     "Resources": {
#         "wafrSQLiSet": {
#             "Type": "AWS::WAFRegional::SqlInjectionMatchSet",
#             "Properties": {
#                 "Name": "wafrSQLiSet",
#                 "SqlInjectionMatchTuples": [
#                     {
#                         "FieldToMatch": {
#                             "Type": "URI"
#                         },
#                         "TextTransformation": "URL_DECODE"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "URI"
#                         },
#                         "TextTransformation": "HTML_ENTITY_DECODE"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "QUERY_STRING"
#                         },
#                         "TextTransformation": "URL_DECODE"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "QUERY_STRING"
#                         },
#                         "TextTransformation": "HTML_ENTITY_DECODE"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "BODY"
#                         },
#                         "TextTransformation": "URL_DECODE"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "BODY"
#                         },
#                         "TextTransformation": "HTML_ENTITY_DECODE"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "HEADER",
#                             "Data": "cookie"
#                         },
#                         "TextTransformation": "URL_DECODE"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "HEADER",
#                             "Data": "cookie"
#                         },
#                         "TextTransformation": "HTML_ENTITY_DECODE"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "HEADER",
#                             "Data": "Authorization"
#                         },
#                         "TextTransformation": "URL_DECODE"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "HEADER",
#                             "Data": "Authorization"
#                         },
#                         "TextTransformation": "HTML_ENTITY_DECODE"
#                     }
#                 ]
#             }
#         },
#         "wafrSQLiRule": {
#             "Type": "AWS::WAFRegional::Rule",
#             "DependsOn": [
#                 "wafrSQLiSet"
#             ],
#             "Properties": {
#                 "MetricName": "wafrSQLiRule",
#                 "Name": "wafr-SQLiRule",
#                 "Predicates": [
#                     {
#                         "Type": "SqlInjectionMatch",
#                         "Negated": false,
#                         "DataId": {
#                             "Ref": "wafrSQLiSet"
#                         }
#                     }
#                 ]
#             }
#         },
#         "MyIPSetWhiteList": {
#             "Type": "AWS::WAFRegional::IPSet",
#             "Properties": {
#                 "Name": "WhiteList IP Address Set",
#                 "IPSetDescriptors": [
#                     {
#                         "Type": "IPV4",
#                         "Value": "155.33.135.11/32"
#                     },
#                     {
#                         "Type": "IPV4",
#                         "Value": "192.0.7.0/24"
#                     }
#                 ]
#             }
#         },
#         "MyIPSetWhiteListRule": {
#             "Type": "AWS::WAFRegional::Rule",
#             "Properties": {
#                 "Name": "WhiteList IP Address Rule",
#                 "MetricName": "MyIPSetWhiteListRule",
#                 "Predicates": [
#                     {
#                         "DataId": {
#                             "Ref": "MyIPSetWhiteList"
#                         },
#                         "Negated": false,
#                         "Type": "IPMatch"
#                     }
#                 ]
#             }
#         },
#         "myIPSetBlacklist": {
#             "Type": "AWS::WAFRegional::IPSet",
#             "Properties": {
#                 "Name": "myIPSetBlacklist",
#                 "IPSetDescriptors": [
#                     {
#                         "Type": "IPV4",
#                         "Value": {
#                             "Ref": "IPtoBlock1"
#                         }
#                     },
#                     {
#                         "Type": "IPV4",
#                         "Value": {
#                             "Ref": "IPtoBlock2"
#                         }
#                     }
#                 ]
#             }
#         },
#         "myIPSetBlacklistRule": {
#             "Type": "AWS::WAFRegional::Rule",
#             "DependsOn": [
#                 "myIPSetBlacklist"
#             ],
#             "Properties": {
#                 "Name": "Blacklist IP Address Rule",
#                 "MetricName": "myIPSetBlacklistRule",
#                 "Predicates": [
#                     {
#                         "DataId": {
#                             "Ref": "myIPSetBlacklist"
#                         },
#                         "Negated": false,
#                         "Type": "IPMatch"
#                     }
#                 ]
#             }
#         },
#         "MyScanProbesSet": {
#             "Type": "AWS::WAFRegional::IPSet",
#             "Properties": {
#                 "Name": "MyScanProbesSet"
#             }
#         },
#         "MyScansProbesRule": {
#             "Type": "AWS::WAFRegional::Rule",
#             "DependsOn": "MyScanProbesSet",
#             "Properties": {
#                 "Name": "MyScansProbesRule",
#                 "MetricName": "SecurityAutomationsScansProbesRule",
#                 "Predicates": [
#                     {
#                         "DataId": {
#                             "Ref": "MyScanProbesSet"
#                         },
#                         "Negated": false,
#                         "Type": "IPMatch"
#                     }
#                 ]
#             }
#         },
#         "DetectXSS": {
#             "Type": "AWS::WAFRegional::XssMatchSet",
#             "Properties": {
#                 "Name": "XssMatchSet",
#                 "XssMatchTuples": [
#                     {
#                         "FieldToMatch": {
#                             "Type": "URI"
#                         },
#                         "TextTransformation": "URL_DECODE"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "URI"
#                         },
#                         "TextTransformation": "HTML_ENTITY_DECODE"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "QUERY_STRING"
#                         },
#                         "TextTransformation": "URL_DECODE"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "QUERY_STRING"
#                         },
#                         "TextTransformation": "HTML_ENTITY_DECODE"
#                     }
#                 ]
#             }
#         },
#         "XSSRule": {
#             "Type": "AWS::WAFRegional::Rule",
#             "Properties": {
#                 "Name": "XSSRule",
#                 "MetricName": "XSSRule",
#                 "Predicates": [
#                     {
#                         "DataId": {
#                             "Ref": "DetectXSS"
#                         },
#                         "Negated": false,
#                         "Type": "XssMatch"
#                     }
#                 ]
#             }
#         },
#         "sizeRestrict": {
#             "Type": "AWS::WAFRegional::SizeConstraintSet",
#             "Properties": {
#                 "Name": "sizeRestrict",
#                 "SizeConstraints": [
#                     {
#                         "FieldToMatch": {
#                             "Type": "URI"
#                         },
#                         "TextTransformation": "NONE",
#                         "ComparisonOperator": "GT",
#                         "Size": "512"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "QUERY_STRING"
#                         },
#                         "TextTransformation": "NONE",
#                         "ComparisonOperator": "GT",
#                         "Size": "1024"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "BODY"
#                         },
#                         "TextTransformation": "NONE",
#                         "ComparisonOperator": "GT",
#                         "Size": "204800"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "HEADER",
#                             "Data": "cookie"
#                         },
#                         "TextTransformation": "NONE",
#                         "ComparisonOperator": "GT",
#                         "Size": "4096"
#                     }
#                 ]
#             }
#         },
#         "reqSizeRule": {
#             "Type": "AWS::WAFRegional::Rule",
#             "DependsOn": [
#                 "sizeRestrict"
#             ],
#             "Properties": {
#                 "MetricName": "reqSizeRule",
#                 "Name": "reqSizeRule",
#                 "Predicates": [
#                     {
#                         "Type": "SizeConstraint",
#                         "Negated": false,
#                         "DataId": {
#                             "Ref": "sizeRestrict"
#                         }
#                     }
#                 ]
#             }
#         },
#         "PathStringSetReferers": {
#             "Type": "AWS::WAFRegional::ByteMatchSet",
#             "Properties": {
#                 "Name": "Path String Referers Set",
#                 "ByteMatchTuples": [
#                     {
#                         "FieldToMatch": {
#                             "Type": "URI"
#                         },
#                         "TargetString": "../",
#                         "TextTransformation": "URL_DECODE",
#                         "PositionalConstraint": "CONTAINS"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "URI"
#                         },
#                         "TargetString": "../",
#                         "TextTransformation": "HTML_ENTITY_DECODE",
#                         "PositionalConstraint": "CONTAINS"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "QUERY_STRING"
#                         },
#                         "TargetString": "../",
#                         "TextTransformation": "URL_DECODE",
#                         "PositionalConstraint": "CONTAINS"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "QUERY_STRING"
#                         },
#                         "TargetString": "../",
#                         "TextTransformation": "HTML_ENTITY_DECODE",
#                         "PositionalConstraint": "CONTAINS"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "URI"
#                         },
#                         "TargetString": "://",
#                         "TextTransformation": "URL_DECODE",
#                         "PositionalConstraint": "CONTAINS"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "URI"
#                         },
#                         "TargetString": "://",
#                         "TextTransformation": "HTML_ENTITY_DECODE",
#                         "PositionalConstraint": "CONTAINS"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "QUERY_STRING"
#                         },
#                         "TargetString": "://",
#                         "TextTransformation": "URL_DECODE",
#                         "PositionalConstraint": "CONTAINS"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "QUERY_STRING"
#                         },
#                         "TargetString": "://",
#                         "TextTransformation": "HTML_ENTITY_DECODE",
#                         "PositionalConstraint": "CONTAINS"
#                     }
#                 ]
#             }
#         },
#         "PathStringSetReferersRule": {
#             "Type": "AWS::WAFsRegional::Rule",
#             "Properties": {
#                 "Name": "PathStringSetReferersRule",
#                 "MetricName": "PathStringSetReferersRule",
#                 "Predicates": [
#                     {
#                         "DataId": {
#                             "Ref": "PathStringSetReferers"
#                         },
#                         "Negated": false,
#                         "Type": "ByteMatch"
#                     }
#                 ]
#             }
#         },
#         "BadReferers": {
#             "Type": "AWS::WAFRegional::ByteMatchSet",
#             "Properties": {
#                 "Name": "Bad Referers",
#                 "ByteMatchTuples": [
#                     {
#                         "FieldToMatch": {
#                             "Type": "HEADER",
#                             "Data": "cookie"
#                         },
#                         "TargetString": "badrefer1",
#                         "TextTransformation": "URL_DECODE",
#                         "PositionalConstraint": "CONTAINS"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "HEADER",
#                             "Data": "authorization"
#                         },
#                         "TargetString": "QGdtYWlsLmNvbQ==",
#                         "TextTransformation": "URL_DECODE",
#                         "PositionalConstraint": "CONTAINS"
#                     }
#                 ]
#             }
#         },
#         "BadReferersRule": {
#             "Type": "AWS::WAFRegional::Rule",
#             "Properties": {
#                 "Name": "BadReferersRule",
#                 "MetricName": "BadReferersRule",
#                 "Predicates": [
#                     {
#                         "DataId": {
#                             "Ref": "BadReferers"
#                         },
#                         "Negated": false,
#                         "Type": "ByteMatch"
#                     }
#                 ]
#             }
#         },
#         "ServerSideIncludesSet": {
#             "Type": "AWS::WAFRegional::ByteMatchSet",
#             "Properties": {
#                 "Name": "Server Side Includes Set",
#                 "ByteMatchTuples": [
#                     {
#                         "FieldToMatch": {
#                             "Type": "URI"
#                         },
#                         "TargetString": "/includes",
#                         "TextTransformation": "URL_DECODE",
#                         "PositionalConstraint": "STARTS_WITH"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "URI"
#                         },
#                         "TargetString": ".cfg",
#                         "TextTransformation": "LOWERCASE",
#                         "PositionalConstraint": "ENDS_WITH"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "URI"
#                         },
#                         "TargetString": ".conf",
#                         "TextTransformation": "LOWERCASE",
#                         "PositionalConstraint": "ENDS_WITH"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "URI"
#                         },
#                         "TargetString": ".config",
#                         "TextTransformation": "LOWERCASE",
#                         "PositionalConstraint": "ENDS_WITH"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "URI"
#                         },
#                         "TargetString": ".ini",
#                         "TextTransformation": "LOWERCASE",
#                         "PositionalConstraint": "ENDS_WITH"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "URI"
#                         },
#                         "TargetString": ".log",
#                         "TextTransformation": "LOWERCASE",
#                         "PositionalConstraint": "ENDS_WITH"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "URI"
#                         },
#                         "TargetString": ".bak",
#                         "TextTransformation": "LOWERCASE",
#                         "PositionalConstraint": "ENDS_WITH"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "URI"
#                         },
#                         "TargetString": ".bakup",
#                         "TextTransformation": "LOWERCASE",
#                         "PositionalConstraint": "ENDS_WITH"
#                     },
#                     {
#                         "FieldToMatch": {
#                             "Type": "URI"
#                         },
#                         "TargetString": ".txt",
#                         "TextTransformation": "LOWERCASE",
#                         "PositionalConstraint": "ENDS_WITH"
#                     }
#                 ]
#             }
#         },
#         "ServerSideIncludesRule": {
#             "Type": "AWS::WAFRegional::Rule",
#             "Properties": {
#                 "Name": "ServerSideIncludesRule",
#                 "MetricName": "ServerSideIncludesRule",
#                 "Predicates": [
#                     {
#                         "DataId": {
#                             "Ref": "ServerSideIncludesSet"
#                         },
#                         "Negated": false,
#                         "Type": "ByteMatch"
#                     }
#                 ]
#             }
#         },
#         "WAFAutoBlockSet": {
#             "Type": "AWS::WAFRegional::IPSet",
#             "Properties": {
#                 "Name": "Auto Block Set"
#             }
#         },
#         "MyAutoBlockRule": {
#             "Type": "AWS::WAFRegional::Rule",
#             "DependsOn": "WAFAutoBlockSet",
#             "Properties": {
#                 "Name": "Auto Block Rule",
#                 "MetricName": "AutoBlockRule",
#                 "Predicates": [
#                     {
#                         "DataId": {
#                             "Ref": "WAFAutoBlockSet"
#                         },
#                         "Negated": false,
#                         "Type": "IPMatch"
#                     }
#                 ]
#             }
#         },
#         "MyWebACL": {
#             "Type": "AWS::WAFRegional::WebACL",
#             "Properties": {
#                 "Name": "MyWebACL",
#                 "DefaultAction": {
#                     "Type": "ALLOW"
#                 },
#                 "MetricName": "MyWebACL",
#                 "Rules": [
#                     {
#                         "Action": {
#                             "Type": "BLOCK"
#                         },
#                         "Priority": 1,
#                         "RuleId": {
#                             "Ref": "reqSizeRule"
#                         }
#                     },
#                     {
#                         "Action": {
#                             "Type": "ALLOW"
#                         },
#                         "Priority": 2,
#                         "RuleId": {
#                             "Ref": "MyIPSetWhiteListRule"
#                         }
#                     },
#                     {
#                         "Action": {
#                             "Type": "BLOCK"
#                         },
#                         "Priority": 3,
#                         "RuleId": {
#                             "Ref": "myIPSetBlacklistRule"
#                         }
#                     },
#                     {
#                         "Action": {
#                             "Type": "BLOCK"
#                         },
#                         "Priority": 4,
#                         "RuleId": {
#                             "Ref": "MyAutoBlockRule"
#                         }
#                     },
#                     {
#                         "Action": {
#                             "Type": "BLOCK"
#                         },
#                         "Priority": 5,
#                         "RuleId": {
#                             "Ref": "wafrSQLiRule"
#                         }
#                     },
#                     {
#                         "Action": {
#                             "Type": "BLOCK"
#                         },
#                         "Priority": 6,
#                         "RuleId": {
#                             "Ref": "BadReferersRule"
#                         }
#                     },
#                     {
#                         "Action": {
#                             "Type": "BLOCK"
#                         },
#                         "Priority": 7,
#                         "RuleId": {
#                             "Ref": "PathStringSetReferersRule"
#                         }
#                     },
#                     {
#                         "Action": {
#                             "Type": "BLOCK"
#                         },
#                         "Priority": 8,
#                         "RuleId": {
#                             "Ref": "ServerSideIncludesRule"
#                         }
#                     },
#                     {
#                         "Action": {
#                             "Type": "BLOCK"
#                         },
#                         "Priority": 9,
#                         "RuleId": {
#                             "Ref": "XSSRule"
#                         }
#                     },
#                     {
#                         "Action": {
#                             "Type": "BLOCK"
#                         },
#                         "Priority": 10,
#                         "RuleId": {
#                             "Ref": "MyScansProbesRule"
#                         }
#                     }
#                 ]
#             }
#         },
#         "MyWebACLAssociation": {
#             "Type": "AWS::WAFRegional::WebACLAssociation",
#             "DependsOn": [
#                 "MyWebACL"
#             ],
#             "Properties": {
#                 "ResourceArn": {
#                     "Ref": "ALBArn"
#                 },
#                 "WebACLId": {
#                     "Ref": "MyWebACL"
#                 }
#             }
#         }
#     }
# }
# STACK
# }