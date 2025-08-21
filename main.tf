

locals {
  RESOURCES_PREFIX = "${lower(var.ENV)}-artisan-linkup"
  ACCOUNTID        = data.aws_caller_identity.current.account_id
  INFO_EMAIL       = "info@email.com"

  DOMAIN_NAME = "api.${var.WEBAPP_DNS}"
  # cognito_domain_name        = lower(var.ENV) == "prod" ? "auth.${var.WEBAPP_DNS}" : "auth.${var.WEBAPP_DNS}"
  cognito_domain_name = var.WEBAPP_DNS
  common_tags = {
    environment = var.ENV
    project     = "artisan-linkup"
    managedby   = "cloud@email.com"
  }
}


module "roles" {
  source           = "./modules/roles"
  ENV              = var.ENV
  AWS_REGION       = var.region
  RESOURCES_PREFIX = local.RESOURCES_PREFIX


}

# POlicy
 module "policy" {
   source                                     = "./modules/policy"
   ENV                                        = var.ENV
   AWS_REGION                                 = var.region
   RESOURCES_PREFIX                           = local.RESOURCES_PREFIX
   CURRENT_ACCOUNT_ID                         = data.aws_caller_identity.current.account_id
   NAME_FUNCTION_ROLE_NAME                    = module.roles.NAME_FUNCTION_ROLE_NAME
   EMAIL_FUNCTION_ROLE_NAME                   = module.roles.EMAIL_FUNCTION_ROLE_NAME 
   ROLE_FUNCTION_ROLE_NAME                    = module.roles.ROLE_FUNCTION_ROLE_NAME
   MFA_SETUP_FUNCTION_ROLE_NAME               = module.roles.MFA_SETUP_FUNCTION_ROLE_NAME


   
  
 }


# Lambda
module "lambda" {
  source           = "./modules/lambda"
  ENV              = var.ENV
  AWS_REGION       = var.region
  RESOURCES_PREFIX = local.RESOURCES_PREFIX
  USER_TABLE_NAME  = module.user_table.table_name
  CLIENT_ID        = module.cognito_end_user.COGNITO_USER_CLIENT_ID_A
  POOL_ID          = module.cognito_end_user.COGNITO_USER_POOL_ID
  CLIENT_SECRET    = module.cognito_end_user.COGNITO_USER_CLIENT_SECRET_A


  LAMBDA_JAVASCRIPT_VERSION                 = var.LAMBDA_JAVASCRIPT_VERSION
  LAMBDA_PYTHON_VERSION                     = var.LAMBDA_PYTHON_VERSION
  NAME_FUNCTION_ROLE_ARN                    = module.roles.NAME_FUNCTION_ROLE_ARN
  EMAIL_FUNCTION_ROLE_ARN         = module.roles.EMAIL_FUNCTION_ROLE_ARN
  ROLE_FUNCTION_ROLE_ARN                    = module.roles.ROLE_FUNCTION_ROLE_ARN
  MFA_SETUP_FUNCTION_ROLE_ARN               = module.roles.MFA_SETUP_FUNCTION_ROLE_ARN

  # ================================== CORE FUNCTIONS=================================     
}


# DYNAMODB TABLE
module "user_table" {
  source           = "./modules/dynamodb/user_table"
  ENV              = var.ENV
  AWS_REGION       = var.region
  RESOURCES_PREFIX = local.RESOURCES_PREFIX
  table_name       = "user_table"
}
module "product_table" {
  source           = "./modules/dynamodb/product_table"
  ENV              = var.ENV
  AWS_REGION       = var.region
  RESOURCES_PREFIX = local.RESOURCES_PREFIX
  table_name       = "product_table"
}

# module "core" {
#   source                                            = "./modules/core"
#   ENV                                               = var.ENV
#   RESOURCES_PREFIX                                  = local.RESOURCES_PREFIX
#   CURRENT_ACCOUNT_ID                                = data.aws_caller_identity.current.account_id
#   API_DOMAIN_NAME                                   = local.DOMAIN_NAME
#   LAMBDA_CREATE_LINK_FUNCTION_ARN                   = module.lambda.LAMBDA_CREATE_LINK_FUNCTION_ARN

#   LAMBDA_NAMES = [

#   ] 
# }

module "open" {
  source                                      = "./modules/open"
  ENV                                         = var.ENV
  RESOURCES_PREFIX                            = local.RESOURCES_PREFIX
  CURRENT_ACCOUNT_ID                          = data.aws_caller_identity.current.account_id
  API_DOMAIN_NAME                             = local.DOMAIN_NAME
  LAMBDA_NAME_FUNCTION_ARN                    = module.lambda.LAMBDA_NAME_FUNCTION_ARN
  LAMBDA_EMAIL_FUNCTION_ARN                   = module.lambda.LAMBDA_EMAIL_FUNCTION_ARN
  LAMBDA_ROLE_FUNCTION_ARN                    = module.lambda.LAMBDA_ROLE_FUNCTION_ARN
  LAMBDA_MFA_SETUP_FUNCTION_ARN               = module.lambda.LAMBDA_MFA_SETUP_FUNCTION_ARN
  

  LAMBDA_NAMES = [
    module.lambda.LAMBDA_NAME_FUNCTION_NAME,
    module.lambda.LAMBDA_EMAIL_FUNCTION_NAME,
    module.lambda.LAMBDA_ROLE_FUNCTION_NAME,
    module.lambda.LAMBDA_MFA_SETUP_FUNCTION_NAME,
  
  ]
}


module "cognito_end_user" {
  source                                 = "./modules/cognito"
  ENV                                    = var.ENV
  COMMON_TAGS                            = local.common_tags
  EMAIL_SENDER                           = local.INFO_EMAIL
  IAM_COGNITO_ASSUMABLE_ROLE_EXTERNAL_ID = var.IAM_COGNITO_ASSUMABLE_ROLE_EXTERNAL_ID
  AWS_REGION                             = data.aws_region.current.id
  CURRENT_ACCOUNT_ID                     = local.ACCOUNTID
  WEBAPP_DNS                             = var.WEBAPP_DNS
  COGNITO_GROUP_LIST                     = var.COGNITO_GROUP_LIST
  RESOURCE_PREFIX                        = local.RESOURCES_PREFIX
  BUCKET_NAME                            = "bucket" #module.s3.MESSAGING_BUCKET_NAME
  RESOURCE                               = "end_user"
  PYTHON_LAMBDA_VERSION                  = var.LAMBDA_PYTHON_VERSION
  COGNITO_DOMAIN_NAME                    = local.cognito_domain_name
  RESEND_API_KEY                         = var.RESEND_API_KEY
  USER_TABLE_NAME                        = module.user_table.table_name

}

# module "s3" {
#   source           = "./modules/s3"
#   RESOURCES_PREFIX = local.RESOURCES_PREFIX
# }


##==================================================
#  SES creation..
##==================================================

# module "ses" {
#   source     = "./modules/ses"
#   FEMI_EMAIL = local.FEMI_EMAIL
#   INFO_EMAIL = local.INFO_EMAIL
# }