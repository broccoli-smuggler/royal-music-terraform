# Configure the Cloudflare provider.
# You may optionally use version directive to prevent breaking changes occurring unannounced.
provider "cloudflare" {
  email = var.cloudflare_email
  api_token = var.cloudflare_token
}

resource "cloudflare_zone_settings_override" "royalmusic" {
  zone_id = var.cloudflare_zone_id
  settings {
    always_online = "on"
    always_use_https = "on"
    automatic_https_rewrites = "on"
    brotli = "on"
    ip_geolocation = "on"
    ipv6 = "on"
    opportunistic_encryption = "on"
    opportunistic_onion = "on"
    ssl = "flexible"
    tls_1_3 = "on"
    websockets = "on"
  }
}

resource "cloudflare_record" "cname-royalmusic" {
  zone_id = var.cloudflare_zone_id
  name    = var.domain_name
  value = module.royalmusictour_website.s3_bucket_website_endpoint
  proxied = true
  type    = "CNAME"
}

resource "cloudflare_record" "www" {
  zone_id = var.cloudflare_zone_id
  name    = "www"
  value   = module.royalmusictour_website.s3_bucket_website_endpoint
  type    = "CNAME"
  proxied = true
}
