# =================================================================
#  NAME ROLE
# =================================================================
resource "aws_iam_role" "name_function_role" {
  name = "NAME_FUNCTION_${var.RESOURCES_PREFIX}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# =================================================================
#  Email ROLE
# =================================================================
resource "aws_iam_role" "email_function_role" {
  name = "EMAIL_FUNCTION_${var.RESOURCES_PREFIX}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# =================================================================
#  ROLE
# =================================================================
resource "aws_iam_role" "role_function_role" {
  name = "ROLE_FUNCTION_${var.RESOURCES_PREFIX}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# =================================================================
#  CONFIRM FORGOT PASSWORD ROLE
# =================================================================
resource "aws_iam_role" "mfa_setup_function_role" {
  name = "MFA_SETUP_FUNCTION_${var.RESOURCES_PREFIX}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

