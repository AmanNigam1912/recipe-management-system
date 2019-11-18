
resource "aws_security_group" "application" {
  name              = "${var.SGApplication}"
  description       = "Security Group to host web application"
  vpc_id            = "${var.vpc_id}"


  # ingress {
  #   from_port       = 22 
  #   to_port         = 22   
  #   protocol        = "${var.aws_security_group_protocol}"
  #   cidr_blocks     = ["0.0.0.0/0"]
  #   #cidr_blocks values??
  # }

  # ingress {
  #   from_port       = 80 
  #   to_port         = 80   
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

  ingress {
    from_port       = 8080 
    to_port         = 8080  
    protocol        = "${var.aws_security_group_protocol}"
    # security_groups = ["${aws_security_group.load_balancer_sg.id}"]
    cidr_blocks     = ["0.0.0.0/0"]
  }

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

  # ingress {
  #   from_port       = 22 
  #   to_port         = 22   
  #   protocol        = "${var.aws_security_group_protocol}"
  #   cidr_blocks     = ["0.0.0.0/0"]
  #   #cidr_blocks values??
  # }

  # ingress {
  #   from_port       = 80 
  #   to_port         = 80   
  #   protocol        = "${var.aws_security_group_protocol}"
  #   cidr_blocks     = ["0.0.0.0/0"]
  # }

  # HTTPS
  ingress {
    from_port       = 443 
    to_port         = 443  
    protocol        = "${var.aws_security_group_protocol}"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  # ingress {
  #   from_port       = 8080 
  #   to_port         = 8080  
  #   protocol        = "${var.aws_security_group_protocol}"
  #   cidr_blocks     = ["0.0.0.0/0"]
  # }

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

resource "aws_launch_configuration" "config_for_auto_scaling" {
  # name                              = "asg_launch_config"
  name_prefix                         = "asg-launch-config" 
# AMI
  image_id                          = "${var.ami}"
  instance_type                     = "t2.nano"
#   YOUR_AWS_KEYNAME - Key Name that should be used for the instance
  key_name                          = "${var.key_name}"  
  associate_public_ip_address       = "true"
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
    min_size                        = "1"
    max_size                        = "5"
    desired_capacity                = "2"    
    # availability_zones              = ["${data.aws_availability_zones.available.names[0]}","${data.aws_availability_zones.available.names[1]}","${data.aws_availability_zones.available.names[2]}"]
    vpc_zone_identifier             = ["${element(tolist(data.aws_subnet_ids.subnet.ids), 0)}","${element(tolist(data.aws_subnet_ids.subnet.ids), 1)}"]
    health_check_type               = "ELB"
    target_group_arns               = ["${aws_lb_target_group.auto_scale_target_group.arn}"]

    lifecycle {
    create_before_destroy = true
  }

    tags = [
    {
      key                 = "Name"
      type                = "KEY_AND_VALUE"
      value               = "EC2_for_web"
    #   key                 = "Environment"
    #   value               = "dev"
      propagate_at_launch = "true"
    }
  ]

  depends_on = ["aws_launch_configuration.config_for_auto_scaling", "aws_lb_target_group.auto_scale_target_group","aws_lb_listener.application_listener"]
}



resource "aws_lb_target_group" "auto_scale_target_group" {
  name     = "auto-scale-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
  health_check {
    interval            = 60
    # path                = "/healthCheck"
    protocol            = "HTTP"
    port                = 8080
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 5
    matcher             = "200,302"
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
  internal           = true
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.load_balancer_sg.id}"]
  subnets            = ["${element(tolist(data.aws_subnet_ids.subnet.ids), 0)}","${element(tolist(data.aws_subnet_ids.subnet.ids), 1)}"]
  ip_address_type    = "ipv4"
# If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false.
  # enable_deletion_protection = false

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
    evaluate_target_health = true
  }
  # depends_on               = ["aws_lb.application_lb"] 
}