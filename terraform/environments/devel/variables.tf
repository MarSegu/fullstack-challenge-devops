variable "environment" {
    type = string
    description = "Environment name"
}

variable "region" {
    type = string
    description = "Region for the implementation"
}

variable "subscription_id" {
    type = string
    default = null
}

variable "tenant_id" {
    type = string
    default = null
}

variable "client_id" {
    type = string
    default = null
}

variable "client_secret" {
    type = string
    default = null
}