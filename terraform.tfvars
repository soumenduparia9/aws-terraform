# VPC variables
vpc_name             = "my-vpc"
vpc_cidr             = "10.0.0.0/16"
vpc_azs              = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
vpc_public_subnets   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
vpc_private_subnets  = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
vpc_database_subnets = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]
vpc_tags             = {"created-by" = "terraform" }