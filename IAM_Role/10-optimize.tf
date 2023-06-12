locals {
    Share_Middle_Name             = var.Share_Middle_Name
    role_policy_attachment_list   = flatten([[for role in var.Role : 
        [ for policy_name in role.attachment_policy : {
            role      = role.name_prefix
            policy    = policy_name
        }] if role.attachment_policy != null ]
    ])
    attachmet_policy_optimize   = distinct(compact(flatten([for role in var.Role : role.attachment_policy ])))
}

data "aws_iam_policy" "attachment_policy" {
    for_each            = { for name in local.attachmet_policy_optimize : name => name if length(local.attachmet_policy_optimize) != 0 } 
    name                = each.key
}

locals {
    policy_list     = data.aws_iam_policy.attachment_policy
}
