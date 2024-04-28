variable "repos" { type = list(string) }
variable "account" { type = string }
variable "oidc_provider_url" { type = string }
variable "oidc_provider_audiences" { type = list(string) }
variable "thumbprint_list" { type = list(string) }
variable "oidc-policy-arn" { type = string }
