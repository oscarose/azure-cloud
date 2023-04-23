variable "virtual_network_name" {
  description = "postgres flexible server virtual network"
  default     = "pgs-network"
  type        = string
}

variable "subnet_name" {
  description = "postgres flexible server virtual network"
  default     = "pgs-subnet"
  type        = string
}

variable "db_user" {
  description = "Database User"
  default     = "datauser"
}

variable "environment" {
  description = "target environment"
  default     = "prod-app"
  type        = string
}

variable "owner" {
  description = "App owners"
  default     = "cloud-warriors"
  type        = string
}

variable "pfsql_vid" {
  default = 12
  type    = number
}

variable "db_password" {
  description = "db password"
  default     = "Oscarose@84"
  type        = string
}

variable "zone_number" {
  description = "zone id number"
  default     = 1
  type        = number
}

variable "storage_mb" {
  default = 32768
  type    = number
}

variable "sku_name" {
  default = "GP_Standard_D4s_v3"
  type    = string
}

