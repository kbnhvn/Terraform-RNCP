region              = "eu-west-3"
vpc_cidr            = "10.0.0.0/16"
public_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnets     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
azs                 = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
instance_type       = "t3.medium"
key_name            = "AWS-RNCP-Infra"
desired_capacity    = 2
max_size            = 3
min_size            = 1
bastion_instance_type = "t3.micro"
ami                 = "ami-00ac45f3035ff009e"  # Ubuntu 24.04 LTS for eu-west-3