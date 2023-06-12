resource "aws_iam_role" "default" {
    for_each            = { for role in var.Role : join("-", ["iam", "role", local.Share_Middle_Name, role.name_prefix]) => role } 
    name                = each.key
    assume_role_policy  = each.value.assume_role_policy
    description         = each.value.description
    tags                = merge(each.value.tags, { "Name" = each.key })
}

resource "aws_iam_role_policy_attachment" "default" {
    for_each            = { for attachment in local.role_policy_attachment_list : join("-", [attachment.role, attachment.policy]) => attachment 
                            if length(local.policy_list) != 0 && length(aws_iam_role.default) != 0 }
    role                = join("-", ["iam", "role", local.Share_Middle_Name, each.value.role])
    policy_arn          = local.policy_list[each.value.policy].arn
}

# resource "aws_iam_instance_profile" "default" {
#     # for_each            = { for role in aws_iam_role.default : role.name => role 
#     #                         if contains([jsondecode(role.assume_role_policy).Statement[0].Principal.Service], "ec2.amazonaws.com")  }
#     for_each            = { for role in var.Role : "${local.share_tags["role"].Name}-${role.name_prefix}" => role if role.create_instance_profile == true  }
#     name                = each.key
#     role                = each.key
# }