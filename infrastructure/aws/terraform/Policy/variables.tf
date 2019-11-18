variable "iam_policy_name" {
    type = "string"
}

variable "iam_policy_description" {
   type = "string" 
}

variable "iam_username" {
    type = "string"
}

variable "CircleCI_Upload_To_S3_policy_name" {
    type = "string" 
}

variable "CircleCI_Upload_To_S3_policy_description" {
    type = "string"
}

variable "CircleCI_Code_Deploy_policy_name" {
    type = "string"
}

variable "CircleCI_Code_Deploy_policy_description" {
    type = "string"
}

variable "region" {
    type = "string"
}

variable "account_id" {
    type = "string"
}

variable "profile" {
    description = "Enter the environment (dev/prod):"
}

variable "application_name" {
    type = "string"
}

variable "CodeDeploy_EC2_S3_policy_name" {
    type = "string" 
}

variable "CodeDeploy_EC2_S3_policy_description" {
    type = "string" 
}

variable "iam_instance_profile" {
  type = "string" 
}
