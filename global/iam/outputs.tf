output "all_arns" {
    value = ["${aws_iam_user.devops.*.arn}"]
    description = "ALl DevOps users"
}
