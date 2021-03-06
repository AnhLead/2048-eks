locals {
  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  service_account_role_arn = module.eks.oidc_provider_arn
}

module "vpc" {
  source          = "../modules/vpc"
  region          = var.region
  name            = var.name
  cidr            = var.cidr
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  tags            = var.tags
  cluster_name    = var.cluster_name
}

module "eks" {
  source                          = "../modules/eks"
  depends_on                      = [module.vpc]
  region                          = var.region
  cluster_name                    = var.cluster_name
  cluster_version                 = var.cluster_version
  max_unavailable_percentage      = var.max_unavailable_percentage
  environment                     = var.environment
  instance_types                  = var.instance_types
  cluster_ip_family               = var.cluster_ip_family
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  tags                            = var.tags
  vpc_id                          = module.vpc.vpc_id
  subnet_ids                      = module.vpc.private_subnets
  service_account_role_arn        = module.eks.oidc_provider_arn
}