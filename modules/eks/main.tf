module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  subnet_ids = var.subnet_ids
  vpc_id     = var.vpc_id

  enable_irsa               = true

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]
      desired_size   = 1
      min_size       = 1
      max_size       = 2

      iam_role_additional_policies = {
      AmazonEKSWorkerNodePolicy             = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
      AmazonEKS_CNI_Policy                  = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
      AmazonEC2ContainerRegistryReadOnly   = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      }
    }
  }

  tags = {
    Terraform = "true"
    Environment = "prod"
  }
}