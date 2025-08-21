# =================================================================
#  NAME
# =================================================================
output "LAMBDA_NAME_FUNCTION_ARN" {
  value = aws_lambda_function.name_function.arn
}
output "LAMBDA_NAME_FUNCTION_NAME" {
  value = aws_lambda_function.name_function.function_name
}

# =================================================================
#  EMAIL
# =================================================================
output "LAMBDA_EMAIL_FUNCTION_ARN" {
  value = aws_lambda_function.email_function.arn
}
output "LAMBDA_EMAIL_FUNCTION_NAME" {
  value = aws_lambda_function.email_function.function_name
}


# =================================================================
#  ROLE
# =================================================================
output "LAMBDA_ROLE_FUNCTION_ARN" {
  value = aws_lambda_function.role_function.arn
}
output "LAMBDA_ROLE_FUNCTION_NAME" {
  value = aws_lambda_function.role_function.function_name
}


# =================================================================
# MFA_SETUP
# =================================================================
output "LAMBDA_MFA_SETUP_FUNCTION_ARN" {
  value = aws_lambda_function.mfa_setup_function.arn
}
output "LAMBDA_MFA_SETUP_FUNCTION_NAME" {
  value = aws_lambda_function.mfa_setup_function.function_name
}