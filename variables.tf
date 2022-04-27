variable "vpc_id" {
  type    = string
  default = "vpc-0f82992e109fea8f9"
}

variable "subnet_id" {
  type    = string
  default = "subnet-039d7bd1c43f973cc"
}
variable "cluster_name" {
  type = string
  default = "eks-kubeginners"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

#variable "rules" {
#  type = list(object({
#    port        = number
#    proto       = string
#    cidr_blocks = list(string)
#  }))
#  default = [
#    {
#      port        = 80
#      proto       = "tcp"
#      cidr_blocks = ["77.4.141.152/32"]
#    },
#    {
#      port        = 22
#      proto       = "tcp"
#      cidr_blocks = ["77.4.141.152/32"]
#    }
#  ]
#}