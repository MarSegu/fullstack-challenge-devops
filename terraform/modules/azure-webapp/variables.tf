variable "environment" {
    type = string
    description = "Environment name"
}

variable "region" {
    type = string
    description = "Region for the implementation"
}

variable "tags" {
    type = map(string)
    description = "tags"
}