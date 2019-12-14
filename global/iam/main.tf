provider "aws" {
    region = "us-east-2"
}

terraform {
    backend "s3" {}
}

resource "aws_iam_user" "devops" {
    count = "${length(var.user_names)}"
    name = "devops-${element(var.user_names, count.index)}"
}

data "aws_iam_policy_document" "ec2_read_only" {
    statement {
        effect = "Allow"
        actions = ["ec2:Describe*"]
        resources = ["*"]
    }
}

resource "aws_iam_policy" "ec2_read_only" {
    name = "ec2-ready-lnly"
    policy = "${data.aws_iam_policy_document.ec2_read_only.json}"
}

resource "aws_iam_user_policy_attachment" "ec2_access" {
    count = "${length(var.user_names)}"
    user = "${element(var.user_names.*.name, count.index)}"
    policy_arn = "${aws_iam_policy.ec2_read_only.arn}"
}
