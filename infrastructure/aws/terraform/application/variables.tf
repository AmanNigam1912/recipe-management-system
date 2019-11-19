
variable "db_instance" {
    type = "string"
    #db.t2.micro
}

variable "db_username" {
    type = "string"
}

variable "db_password" {
    type = "string"
}

variable "db_identifier" {
    type = "string"     
    #csye6225-fall2019
}

variable "db_engine" {
    type = "string"
    #mysql
}

variable "db_name" {
    type = "string"
    #csye6225
}

variable "db_engine_version" {
    type = "string"
    #to be found and hardcoded
}

variable "aws_security_group_protocol" {
    type = "string"
    #tcp
}

variable "db_multi_az" {
    type = "string"
    #false
}

variable "db_publicly_accessible" {
    type = "string"
    #true
}

# variable "rds_subnet1" {
#     # default = "subnet-03312b8765858aaa6"
#     type = "string"
# }

# variable "rds_subnet2" {
#     # default = "subnet-06927732034bd16df"
#     type = "string"
# }

variable "vpc_id" {
    type = "string"
}

variable "subnetCidrBlock" {
    type = "list"
}

variable "db_skip_final_snapshot" {
    type = "string"
}

variable "s3_bucket" {
    type = "string"
}

variable "s3_acl" {
    type = "string"
}

variable "s3_force_destroy" {
    type = "string"
}

variable "s3_lifecycle_id" {
    type = "string"  
    #s3_lifecycle_id  
}

variable "s3_lifecycle_enabled" {
    type = "string"
    #true
}

# variable "s3_lifecycle_prefix" {
#     type = "string" 
#     #log/     
# }

variable "s3_lifecycle_transition_days" {
    type = "string"
    #30
}

variable "s3_lifecycle_transition_storage_class" {
    type = "string"
    #STANDARD_IA
}

variable "s3_bucket_name" {
    type = "string"
}

variable "ami" {
    type = "string"
}

variable "instance_type" {
    type = "string"
}

variable "disable_api_termination" {
    type = "string"
}

variable "volume_size" {
    type = "string"
}

variable "volume_type" {
    type = "string"
}

variable "delete_on_termination" {
    type = "string"
}

variable "device_name" {
    type = "string"
}

variable "subnetZones" {
    type = "list"
}

variable "dynamoDB_name" {
    type = "string"
}

variable "dynamoDB_hashKey" {
    type = "string"
}

variable "dynamoDB_writeCapacity" {
    type = "string"
}

variable "dynamoDB_readCapacity" {
    type = "string"
}

variable "SGDatabase" {
    type = "string"
}

variable "SGApplication" {
    type = "string"
}

variable "rds_subnet_group_name" {
    type = "string"
}

variable "db_storage_type" {
    type = "string"
}

variable "db_allocated_storage" {
    type = "string"
}

variable "ec2_name" {
    type = "string"
}

variable "key_name" {
    type = "string"
}

# variable "name_ami_role_policy" {
#     type = "string"
# }

# variable "iam_username" {
#     type = "string"
# }



# variable "CodeDeploy_EC2_S3_policy_name" {
#     type = "string" 
# }

# variable "CodeDeploy_EC2_S3_policy_description" {
#     type = "string" 
# }

# variable "CircleCI_Upload_To_S3_policy_name" {
#     type = "string" 
# }

# variable "CircleCI_Upload_To_S3_policy_description" {
#     type = "string"
# }

# variable "CircleCI_Code_Deploy_policy_name" {
#     type = "string"
# }

# variable "CircleCI_Code_Deploy_policy_description" {
#     type = "string"
# }


variable "region" {
    type = "string"
}

variable "account_id" {
    type = "string"
}

# variable "code_deploy_application_name" {
#     type = "string"
# }

# variable "compute_platform" {
#    type = "string" 
# }

variable "application_name" {
    type = "string"
}

variable "s3_bucket_codedeploy" {
    type = "string"
}

variable "s3_bucket_name_codedeploy" {
    type = "string"
}

variable "s3_lifecycle_id_codedeploy" {
    type = "string"
}

variable "s3_lifecycle_transition_days_codedeploy" {
    type = "string"
}

# variable "codedeploy_bucket_name" {
#     type = "string"
# }


variable "profile" {
    description = "Enter the environment (dev/prod):"
}

variable "iam_instance_profile" {
  type = "string" 
}

variable "domain" {
    type = "string"
}

variable "lambda_role" {
    type = "string"
}

variable "timeToLive" {
   type = "string"
}
