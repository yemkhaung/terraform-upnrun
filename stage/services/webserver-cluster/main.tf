provider "aws" {
  region  = "us-east-2"
  version = "~> 2.0"
}

terraform {
  backend "s3" {
    # This backend configuration is filled in automatically by Terragrunt
  }
}

module "webserver-cluster" {
  source       = "../../../modules/services/webserver-cluster"

  cluster_name = "tfupnrun-webserver-stage"
  
  # db remote state bucket
  db_remote_state_bucket = "terraformupnrunning-tfstate"
  db_remote_state_key    = "data-stores/mysql/stage.tfstate"
  
  # instance autoscaling group
  ami = "ami-0c55b159cbfafe1f0"
  server_text        = "New server"
  server_port        = 8080
  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 2
  enable_autoscaling = false
}
