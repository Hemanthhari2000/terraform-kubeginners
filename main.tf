provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
}

data "aws_subnet_ids" "subnets" {
  vpc_id = var.vpc_id

}

#data "aws_availability_zones" "available" {
#
#}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "17.24.0"
  cluster_name    = var.cluster_name
  cluster_version = "1.20"

  //creates kubeconfig file to use kubectl
  write_kubeconfig = true

  subnets         = [tolist(data.aws_subnet_ids.subnets.ids)[0],tolist(data.aws_subnet_ids.subnets.ids)[1]]
  vpc_id = var.vpc_id

  tags = {
    Name = "kubeginners-cluster"
  }

  //manage_aws_auth = false

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = var.instance_type
      additional_userdata           = fileexists("user-data.sh") ? file("user-data.sh") : null
      additional_security_group_ids = [aws_security_group.kubeginners_worker_group_one_sg.id]
      asg_desired_capacity          = 2
    }
#    {
#      name                          = "worker-group-2"
#      instance_type                 = var.instance_type
#      //additional_userdata           = "echo foo bar"
#      additional_security_group_ids = [aws_security_group.kubeginners_worker_group_two_sg.id]
#      asg_desired_capacity          = 1
#    },
  ]
}

data "aws_eks_cluster" "kubeginners_cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "kubeginners_cluster_auth" {
  name = module.eks.cluster_id
}
