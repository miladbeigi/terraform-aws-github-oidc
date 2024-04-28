# IAM ROLE
output "iam_role_arn" {
  value = aws_iam_role.oidc-role.arn
}
