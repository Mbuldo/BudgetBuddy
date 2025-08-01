variable "project_name" {
  default = "budgetbuddy"
}

variable "location" {
  default = "East US"
}

variable "budgetbuddy" {
  description = "The name of the Docker image (and used as identifier)"
  type        = string
  default     = "budgetbuddy"
}

variable "client_id" {
  description = "Azure client (application) ID"
  type        = string
}

variable "client_secret" {
  description = "Azure client secret"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}
