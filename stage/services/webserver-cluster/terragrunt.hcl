# store remote state file in S3
remote_state {
    backend = "s3"
    config = {
        encrypt = true
        bucket = "terraformupnrunning-tfstate"
        key = "services/webserver-cluster/stage.tfstate"
        region = "us-east-2"
        dynamodb_table = "tfupnrunning-lock"
    }
}