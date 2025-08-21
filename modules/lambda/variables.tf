variable "ENV" {}
variable "AWS_REGION" {}
variable "LAMBDA_PYTHON_VERSION" {}
variable "LAMBDA_JAVASCRIPT_VERSION" {}
variable "RESOURCES_PREFIX" {}
variable "USER_TABLE_NAME" {

}
variable "MONGODB_URI" {
  default = "mongodb+srv://abdulrauf:ninjaH2r@artisan-customer-api.uvgae37.mongodb.net/?retryWrites=true&w=majority&appName=Artisan-customer-ap"
}
variable "CLIENT_SECRET" {
}
variable "CLIENT_ID" {
}
variable "POOL_ID" {
}
variable "NAME_FUNCTION_ROLE_ARN" {}
variable "EMAIL_FUNCTION_ROLE_ARN" {}
variable "ROLE_FUNCTION_ROLE_ARN" {}
variable "MFA_SETUP_FUNCTION_ROLE_ARN"  {

}

