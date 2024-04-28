resource "aws_iam_openid_connect_provider" "github" {
  url             = var.oidc_provider_url
  client_id_list  = var.oidc_provider_audiences
  thumbprint_list = var.thumbprint_list
}

resource "aws_iam_role" "oidc-role" {
  name = "oidc-role-${var.account}"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${aws_iam_openid_connect_provider.github.arn}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "token.actions.githubusercontent.com:aud" : "sts.amazonaws.com"
          },
          "StringLike" : {
            "token.actions.githubusercontent.com:sub" : [for repo in var.repos : "repo:${repo}"]
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "oidc-policy-attachment" {
  role       = aws_iam_role.oidc-role.name
  policy_arn = var.oidc-policy-arn
}
