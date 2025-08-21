variable "CURRENT_ACCOUNT_ID" {}
variable "ENV" {}
variable "BASE_PATH" {
  default = "open"
}

variable "LAMBDA_NAMES" {
  description = "contains Names of lambda(s) to be added into <aws_lambda_permission> resource"
  type        = list(string)
}
variable "RESOURCES_PREFIX" {}
variable "API_DOMAIN_NAME" {

}




variable "LAMBDA_NAME_FUNCTION_ARN" {}
variable "LAMBDA_EMAIL_FUNCTION_ARN" {}
variable "LAMBDA_ROLE_FUNCTION_ARN" {

}
variable "LAMBDA_MFA_SETUP_FUNCTION_ARN" {
  
}
