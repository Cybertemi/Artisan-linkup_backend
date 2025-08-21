# =================================================================
#  SIGNUP  ROLE
# =================================================================
output "NAME_FUNCTION_ROLE_ARN" {
  value = aws_iam_role.name_function_role.arn
}
output "NAME_FUNCTION_ROLE_NAME" {
  value = aws_iam_role.name_function_role.name
}

# =================================================================
#  FORGOT_PASSWORD ROLE
# =================================================================
output "EMAIL_FUNCTION_ROLE_ARN" {
  value = aws_iam_role.email_function_role.arn
}
output "EMAIL_FUNCTION_ROLE_NAME" {
  value = aws_iam_role.email_function_role.name
}

# =================================================================
#  CONFIRM SIGNUP  ROLE
# =================================================================
output "ROLE_FUNCTION_ROLE_ARN" {
  value = aws_iam_role.role_function_role.arn
}
output "ROLE_FUNCTION_ROLE_NAME" {
  value = aws_iam_role.role_function_role.name
}

# =================================================================
#  CONFIRM SIGNUP  ROLE
# =================================================================
output "MFA_SETUP_FUNCTION_ROLE_ARN" {
  value = aws_iam_role.mfa_setup_function_role.arn
}
output "MFA_SETUP_FUNCTION_ROLE_NAME" {
  value = aws_iam_role.mfa_setup_function_role.name
}

