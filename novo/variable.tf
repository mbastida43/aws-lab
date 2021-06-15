variable "cx2k19key" {
  type    = string
  default = "win-2019-3cx-callface"
}

variable "cxsubnet" {
  type    = string
  default = "subnet-xxxxxxxxxx"
}

variable "cxec2type" {
  type    = string
  default = "t2.large"
}

variable "cxsg" {
  type = map(list(string))
  default = {
    "sgc-my-default" = ["sg-xxxxxxxxxxxx"]
  }
}

variable "default_tags" {
  type = map(string)
  default = {
    Billing        = "XXXXX"
    Terraform      = "yes"
    Backup         = "yes"
  }
}

variable "cloudflare_zone_id" {
  type    = string
  default = "XXXXXXXXXXXXXXXXXXXXXXX"
}
