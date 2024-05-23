variable "storage_account_name" {
  type        = string
  description = "Name of the storage account."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "service_principal_id" {
  description = "Azure AD service principal ID."
  type        = string
}

variable "container_name" {
  description = "Name of the container."
  type        = string
  validation {
    condition     = can(regex("^[a-z\\d][a-z\\d-]+[a-z\\d]$", var.container_name)) && length(var.container_name) > 2 && length(var.container_name) < 64
    error_message = "Invalid container name."
  }
}

variable "tags" {
  default     = {}
  description = "Resource tags."
  type        = map(string)
}
