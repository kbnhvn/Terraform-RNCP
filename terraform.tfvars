region              = "eu-west-3"
vpc_name            = "kbnhvn-vpc"
vpc_cidr            = "10.0.0.0/16"
cluster_name        = "kbnhvn-cluster"
prefix              = "airquality"
environment         = "dev"
desired_capacity    = 2
max_capacity        = 5
min_capacity        = 0
instance_type       = "t3.medium"
domain_name         = "kbnhvn-project.eu"