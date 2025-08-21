data "archive_file" "lambda_name_archive" {
  type        = "zip"
  source_dir  = "${path.module}/codes/name"
  output_path = "${path.module}/codes/zip/name.zip"
}


data "archive_file" "lambda_email_archive" {
  type        = "zip"
  source_dir  = "${path.module}/codes/email"
  output_path = "${path.module}/codes/zip/email.zip"
}
data "archive_file" "lambda_role_archive" {
  type        = "zip"
  source_dir  = "${path.module}/codes/role"
  output_path = "${path.module}/codes/zip/role.zip"
}

data "archive_file" "lambda_mfa_setup_archive" {
  type        = "zip"
  source_dir  = "${path.module}/codes/mfa_setup"
  output_path = "${path.module}/codes/zip/mfa_setup.zip"
}

