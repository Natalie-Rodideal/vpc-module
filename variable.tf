
variable "region" {
  description = "Region in which AWS Resources to be created"
  type        = string
  default     = "us-east-1"
}
# 
variable "accountname" {
  type    = string
  default = ""

}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = ""
}

# VPC CIDR Block
variable "cidr" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.164.32.0/22"
}

variable "approver" {
  type    = string
  default = ""

}
variable "Created_By" {
  type    = string
  default = "terraform"
}
# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type        = string
  default     = "dev"
}
variable "business-unit" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type        = string
  default     = "DevOps"
}
variable "costcenter" {
  type    = string
  default = "000000"
}
variable "owner" {
  type    = string
  default = ""
}
variable "Terraform_Managed" {
  type    = bool
  default = "true"
}
variable "private_subnet1" {
  type    = string
  default = ""
}
variable "private_subnet2" {
  type    = string
  default = ""
}
variable "public_subnet1" {
  type    = string
  default = ""
}
variable "public_subnet2" {
  type    = string
  default = ""
}

variable "tgw_id" {
  description = "ID for the Transit Gateway US-EAST-01"
  default     = "tgw"
}



