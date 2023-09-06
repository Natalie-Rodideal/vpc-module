locals {
  required_tags = {
    project           = var.accountname,
    name              = "${var.business-unit}-${var.environment}"
    environment       = var.environment,
    approver          = var.approver,
    business-unit     = var.business-unit,
    costcenter        = var.costcenter,
    owner             = var.owner
    Created_By        = var.Created_By
    Terraform_Managed = var.Terraform_Managed
  }
  region        = var.region
  cidr          = var.cidr
  combined_tags = local.required_tags
}
