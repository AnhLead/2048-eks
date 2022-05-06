provider "aws" {
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-907315980731809"
    key = "default.tfstate"
    region = "eu-west-2"
  }
}

module "kubernetes" {
  source = "./kubernetes"
  ami = "# Your configured AMI"
  cluster_name = "cluster-1"
  master_instance_type = "t3.medium"
  nodes_max_size = 1
  nodes_min_size = 1
  private_subnet01_num = "1"
  public_subnet01_num = "2"
  region = "eu-west-2"
  vpc_cidr_block = "10.240.0.0/16"
  worker_instance_type = "t2.micro"
  vpc_name = "kubernetes"
  ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCwEdBKMtp6P6yne2Vg7A4H2DNAvJWcYvtPE4PCs4ypZHL65i9vQ0eEKqc+lu7r6WggcMXxl6GVeYS5hE6UVKZWwBGA0AxI8VbfhFFJs+wQb8If4s/92Mo2yiFEvHXWWUbZL2NiIsZXlS/m/oXyj7cVh5LYf25/3SSDDTWFAGoWDwJ2oAotWbqw+Ws/KlfkPbGet3x91RwReTi5iej2JZXxeQvWpaxgdM3r9hhomh7lN2Y4lIzUY4/xwcvXoly3XqIbxKiswSO+eM0uKoE8WlKzwtZu/c/uJANerbiR0MSdVVWZnyUa4vA9PoZ2+KHblRolAC/Ncs512ctyNFMP89HS97I3thrW8NMaxOsz5J/sFHXoNIc0dJFPBKWaEziBGokpMlt1gPPhR9yaKZUtBFJo5cIK38yAUFh1WY/2LjUCvua7Y8lfCCxVXcHW28ADK95cF2NnvUq3BXGEMVeHU6UDURa3VtwlMV86ttG7cq1/+MQjeSAI81Cd0vldyTGIwZM= anh@DESKTOP-GUC58HB"
}

