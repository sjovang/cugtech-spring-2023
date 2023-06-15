variable "root_id" {
  type    = string
  default = "myorg"
}

variable "root_name" {
  type    = string
  default = "My Organization"
}

variable "default_location" {
  type    = string
  default = "westeurope"
}

variable "sandbox_subscriptions" {
  type    = list(string)
  default = []
}