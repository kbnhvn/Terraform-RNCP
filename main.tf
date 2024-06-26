provider "aws" {
  region = var.region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

module "vpc" {
  source  = "./modules/vpc"
  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
  cluster_name    = var.cluster_name
}

module "iam" {
  source = "./modules/iam"
  s3_buckets = [
    module.storage.etcd_backup_bucket,
    module.storage.postgres_backup_bucket,
    module.storage.elasticsearch_backup_bucket,
    module.storage.efs_storage
  ]
}

module "storage" {
  source      = "./modules/storage"
  prefix      = var.prefix
  environment = var.environment
  private_subnet_1 = module.vpc.private_subnet_1
  private_subnet_2 = module.vpc.private_subnet_2
  private_subnet_3 = module.vpc.private_subnet_3
  efs-mount-sg = module.vpc.efs-mount-sg
}

module "eks" {
  source           = "./modules/eks"
  cluster_name     = var.cluster_name
  desired_size     = var.desired_capacity
  max_size         = var.max_capacity
  min_size         = var.min_capacity
  instance_type    = var.instance_type
  nodes_role_arn   = module.iam.eks_role_nodes
  cluster_role_arn = module.iam.eks_role_cluster
  public_subnet_1  = module.vpc.public_subnet_1
  public_subnet_2  = module.vpc.public_subnet_2
  public_subnet_3  = module.vpc.public_subnet_3
  private_subnet_1 = module.vpc.private_subnet_1
  private_subnet_2 = module.vpc.private_subnet_2
  private_subnet_3 = module.vpc.private_subnet_3
  cluster_policy   = module.iam.cluster_policy
  workers_policy   = module.iam.workers_policy 
  cni_policy       = module.iam.cni_policy
  ec2_container_registry = module.iam.ec2_container_registry
}

terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-kbnhvn-9612"
    key    = "primary/terraform.tfstate"
    region = "eu-west-3"
  }
}
