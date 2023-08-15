locals {
    Share_Middle_Name   = var.Share_Middle_Name
    # role_optimize_list  = distinct(compact(flatten([for ni in var.NotebookInstance : ni.role_name ])))
}

# data "aws_iam_role" "role" {
#     for_each    = { for role_name in local.role_optimize_list : role_name => role_name if length(local.role_optimize_list) != 0 }
#     name        = each.key
# }

# locals {
#     role_list   = data.aws_iam_role.role
# }