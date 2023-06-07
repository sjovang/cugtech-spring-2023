variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
}

variable "vnet_address_space" {
  type = list(string)
}