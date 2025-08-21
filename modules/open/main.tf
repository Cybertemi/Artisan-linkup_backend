data "template_file" "swagger" {
  template = file("${path.module}/swagger/swagger.yml")
  vars = {
    ACCOUNTID                                   = "${var.CURRENT_ACCOUNT_ID}"
    ENV                                         = "${var.ENV}"
    basePath                                    = "${var.BASE_PATH}"
    LAMBDA_NAME_FUNCTION_ARN                    = "${var.LAMBDA_NAME_FUNCTION_ARN}"
    LAMBDA_EMAIL_FUNCTION_ARN                   = var.LAMBDA_EMAIL_FUNCTION_ARN
    LAMBDA_ROLE_FUNCTION_ARN                    = var.LAMBDA_ROLE_FUNCTION_ARN
    LAMBDA_MFA_SETUP_FUNCTION_ARN               = "${var.LAMBDA_MFA_SETUP_FUNCTION_ARN}"

  }
}

resource "aws_api_gateway_rest_api" "api_gateway" {
  body                         = data.template_file.swagger.rendered
  description                  = "API Gateway REST API for Noughttrapper APP"
  name                         = "${var.RESOURCES_PREFIX}-open-rest-api"
  disable_execute_api_endpoint = true
}



# resource "aws_api_gateway_base_path_mapping" "api_domain_map" {
#   api_id      = aws_api_gateway_rest_api.api_gateway.id
#   domain_name = aws_api_gateway_domain_name.api_custom_domain.domain_name
#   stage_name  = aws_api_gateway_stage.gateway_stage.stage_name
#   base_path   = var.BASE_PATH
# }

resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id

  lifecycle {
    create_before_destroy = true
  }

  triggers = {
    redeployment = sha1(data.template_file.swagger.rendered)
  }

  depends_on = [
    aws_lambda_permission.lambda_permissions,
    aws_api_gateway_rest_api_policy.api_policy
  ]
}

resource "aws_api_gateway_stage" "gateway_stage" {
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  stage_name    = var.ENV
}

data "aws_iam_policy_document" "api_gateway_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = ["execute-api:Invoke"]
    resources = [
      aws_api_gateway_rest_api.api_gateway.execution_arn,
      "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*"
    ]
  }
}

resource "aws_api_gateway_rest_api_policy" "api_policy" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  policy      = data.aws_iam_policy_document.api_gateway_policy.json
}

resource "aws_lambda_permission" "lambda_permissions" {
  count         = length(var.LAMBDA_NAMES)
  function_name = var.LAMBDA_NAMES[count.index]
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/*"
  depends_on = [
    aws_api_gateway_rest_api.api_gateway
  ]
}
