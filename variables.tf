variable "artifact_dir" {
  description = "Path to your static website"
  type        = string
  default     = "../gatsby-dummy/public"
}

variable "app" {
  description = "Name of your app."
  type        = string
  default     = "royalmusictour"
}

variable "stage" {
  description = "Stage where app should be deployed like dev, staging or prod."
  default     = "prod"
  type        = string
}

variable "profile" {
  description = "Name of the aws profile."
  type        = string
  default     = "royalmusic"
}

variable "domain_name" {
  description = "Name of your app."
  type        = string
  default     = "royalmusictour.com"
}

variable "cloudflare_email" {
  type = string
  description = "Load from .tfvars. Email address of user for cloudflare"
}

variable "cloudflare_token" {
  type = string
  description = "Load from .tfvars. Secret token from cloudflare"
}

variable "cloudflare_zone_id" {
  type = string
  description = "Load from .tfvars. Zone Id from cloudflare."
}
