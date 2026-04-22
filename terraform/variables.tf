variable "project_id" {
  description = "gcp proj id"
  type        = string
  default     = "dos32-terraform"
}
variable "region" {
  description = "gcp регион"
  type        = string
  default     = "europe-central2"
}
variable "allowed_cidr" {
  description = "Адрес для доступа к серверу (заменить на свой, оставлю публичный (все) для КР)"
  type        = string
  default     = "0.0.0.0/0"
}
