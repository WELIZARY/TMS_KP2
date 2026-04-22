variable "instance_name" {
  type    = string
}
variable "machine_type" {
  type    = string
  default = "e2-small"
}
variable "zone" {
  type = string
}
variable "image" {
  type    = string
  default = "ubuntu-os-cloud/ubuntu-2204-lts"
}
variable "network" {
  type    = string
  default = "default"
}
variable "tags" {
  type    = list(string)
  default = []
}
variable "static_ip" {
  description = "внешний ip для vm"
  type        = string
}
