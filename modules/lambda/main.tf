locals {
  LAMBDA_VERSION = "v1"

  layers = ["${aws_lambda_layer_version.javascript_layer.arn}", "${aws_lambda_layer_version.mongoose_layer.arn}"]
}

################################################################################
# Layer
################################################################################


resource "aws_lambda_layer_version" "javascript_layer" {
  filename                 = "${path.module}/layers/javascript_layer.zip"
  layer_name               = "${var.RESOURCES_PREFIX}-javascript-layer"
  compatible_runtimes      = [var.LAMBDA_JAVASCRIPT_VERSION]
  compatible_architectures = ["x86_64", "arm64"]
  description              = "javascript layer for node lambdas"
}
resource "aws_lambda_layer_version" "mongoose_layer" {
  filename                 = "${path.module}/layers/mongoose-layer.zip"
  layer_name               = "${var.RESOURCES_PREFIX}-mongoose-layer"
  compatible_runtimes      = [var.LAMBDA_JAVASCRIPT_VERSION]
  compatible_architectures = ["x86_64", "arm64"]
  description              = "Moongoose layer for node lambdas"
}

################################################################################
# Lambda
################################################################################

# resource "aws_lambda_function" "lambda_messaging_templates" {
#   filename         = "${path.module}/codes/zip/messaging_templates.zip"
#   function_name    = "${var.RESOURCES_PREFIX}-messaging-templates"
#   role             = var.LAMBDA_MESSAGING_TEMPLATES_ROLE_ARN
#   handler          = "messaging_templates.lambda_handler"
#   source_code_hash = data.archive_file.lambda_messaging_templates_archive.output_base64sha256
#   runtime          = var.LAMBDA_PYTHON_VERSION
#   timeout          = 300
#   environment {
#     variables = {
#       ENV                   = "${var.ENV}"
#       MESSAGING_BUCKET_NAME = "${var.MESSAGING_BUCKET_NAME}"
#       INFO_EMAIL            = "${var.INFO_EMAIL}"
#       USER_TABLE_NAME       = "${var.USER_TABLE_NAME}"
#       CURRENT_AWS_REGION    = "${var.AWS_REGION}"
#     }
#   }
#   layers = ["${aws_lambda_layer_version.lambda_utils_layer.arn}", "${aws_lambda_layer_version.python_layer.arn}", "${aws_lambda_layer_version.default_layer.arn}"]
# }

/*
 OOO   PPPP   EEEEE  N   N
O   O  P   P  E      NN  N
O   O  PPPP   EEEE   N N N
O   O  P      E      N  NN
 OOO   P      EEEEE  N   N
*/


/*
  ____    ___   ____   _____ 
 / ___|  / _ \ |  _ \ | ____|
| |     | | | || |_) ||  _|  
| |___  | |_| ||  _ < | |___ 
 \____|  \___/ |_| \_\|_____|
*/


# =================================================================
# Create a Lambda function for name function
# =========================================================================

resource "aws_lambda_function" "name_function" {
  filename         = "${path.module}/codes/zip/name.zip"
  function_name    = "${var.RESOURCES_PREFIX}-name-${local.LAMBDA_VERSION}"
  role             = var.NAME_FUNCTION_ROLE_ARN
  handler          = "name.lambda_handler"
  source_code_hash = data.archive_file.lambda_name_archive.output_base64sha256
  runtime          = var.LAMBDA_JAVASCRIPT_VERSION
  timeout          = 180
  memory_size      = 1024

  environment {
    variables = {
      ENV           = "${var.ENV}"
      POOL_ID       = var.POOL_ID
      CLIENT_ID     = var.CLIENT_ID
      CLIENT_SECRET = var.CLIENT_SECRET
      MONGODB_URI   = var.MONGODB_URI

    }
  }
  layers = local.layers
}


# =================================================================
# Create a Lambda function for email function
# =========================================================================
resource "aws_lambda_function" "email_function" {
  filename         = "${path.module}/codes/zip/email.zip"
  function_name    = "${var.RESOURCES_PREFIX}-email-${local.LAMBDA_VERSION}"
  role             = var.EMAIL_FUNCTION_ROLE_ARN
  handler          = "email.lambda_handler"
  source_code_hash = data.archive_file.lambda_email_archive.output_base64sha256
  runtime          = var.LAMBDA_JAVASCRIPT_VERSION
  timeout          = 180
  memory_size      = 1024

  environment {
    variables = {
      ENV           = "${var.ENV}"
      POOL_ID       = var.POOL_ID
      CLIENT_ID     = var.CLIENT_ID
      CLIENT_SECRET = var.CLIENT_SECRET
      MONGODB_URI   = var.MONGODB_URI
    }
  }
  layers = local.layers
}



# =================================================================
# Create a Lambda function for role
# =========================================================================
resource "aws_lambda_function" "role_function" {
  filename         = "${path.module}/codes/zip/role.zip"
  function_name    = "${var.RESOURCES_PREFIX}-role-${local.LAMBDA_VERSION}"
  role             = var.ROLE_FUNCTION_ROLE_ARN
  handler          = "role.lambda_handler"
  source_code_hash = data.archive_file.lambda_role_archive.output_base64sha256
  runtime          = var.LAMBDA_JAVASCRIPT_VERSION
  timeout          = 180
  memory_size      = 1024

  environment {
    variables = {
      ENV         = "${var.ENV}"
      POOL_ID = var.POOL_ID
      CLIENT_ID = var.CLIENT_ID
      CLIENT_SECRET = var.CLIENT_SECRET
      # MONGODB_URI = var.MONGODB_URI
    }
  }

  layers = ["${aws_lambda_layer_version.javascript_layer.arn}", "${aws_lambda_layer_version.mongoose_layer.arn}"]
}



# =================================================================
# Create a Lambda function for mfa_setup
# =========================================================================
resource "aws_lambda_function" "mfa_setup_function" {
  filename         = "${path.module}/codes/zip/mfa_setup.zip"
  function_name    = "${var.RESOURCES_PREFIX}-status-${local.LAMBDA_VERSION}"
  role             = var.MFA_SETUP_FUNCTION_ROLE_ARN
  handler          = "mfa_setup.lambda_handler"
  source_code_hash = data.archive_file.lambda_mfa_setup_archive.output_base64sha256
  runtime          = var.LAMBDA_JAVASCRIPT_VERSION
  timeout          = 180
  memory_size      = 1024

  environment {
    variables = {
      ENV         = "${var.ENV}"
      POOL_ID = var.POOL_ID
      CLIENT_ID = var.CLIENT_ID
      CLIENT_SECRET = var.CLIENT_SECRET
      # LINKS_TABLE = "${var.LINKS_TABLE}"

    }
  }
  layers = local.layers
}

