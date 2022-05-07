provider "aws" {
  region     = var.region
}

terraform {
  backend "s3" {
   bucket         = "tf-state-bucket-ae682c3b213de3a8"
   key            = "2048-eks/terraform/s3terraform.tfstate"
   region         = "eu-west-2"
   dynamodb_table = "terraform-state"
  }

    required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.72"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.10"
    }
  }
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.eks.cluster_id]
  }
}