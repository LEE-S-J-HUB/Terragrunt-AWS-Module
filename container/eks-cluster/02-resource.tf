locals {
    Share_Middle_Name          = var.Share_Middle_Name
    sub_ids             = var.sub_id
    # role_prefix_list    = distinct(compact([ for cluster in var.eks_cluster: cluster.role_name_prefix ]))
}

# data "aws_iam_role" "customer_role" {
#     for_each            = { for name_prefix in local.role_prefix_list : name_prefix => name_prefix } 
#     name                = "${local.share_tags["role"].Name}-${each.key}"
# }

resource "aws_eks_cluster" "default" {
    for_each            = { for cluster in var.eks_cluster : cluster.identifier => cluster }
    name                = each.key
    # role_arn            = data.aws_iam_role.customer_role["${each.value.role_name_prefix}"].arn
    role_arn            = each.value.role_arn
    version             = each.value.version
    vpc_config {
        subnet_ids              = compact([ for sub_identifier in each.value.sub_identifiers : local.sub_ids[sub_identifier] ])
        # security_group_ids      = compact([ for name_prefix in each.value.scg_name_prefix_list : local.scg_ids["${local.share_tags["scg"].Name}-${name_prefix}"] ])
        endpoint_public_access  = each.value.endpoint_public_access
        endpoint_private_access = each.value.endpoint_private_access
        public_access_cidrs     = distinct(each.value.public_access_cidrs)
    }
}