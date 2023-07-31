### AWS Security Group
resource "aws_security_group" "default" {
    for_each            = { for scg in local.SecurityGroup_Optimize : scg.identifier => scg if length(local.SecurityGroup_Optimize) != 0 }
    vpc_id              = var.vpc_id[each.value.vpc_identifier]
    name                = join("-", ["scg", local.Share_Middle_Name, each.value.net_env, each.value.name_prefix])
    description         = each.value.description
    tags                = merge(each.value.tags, {
                                "Name" = join("-", ["scg", local.Share_Middle_Name, each.value.net_env, each.value.name_prefix]) 
                        })
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
}

locals {
    # scg_ids = { for key, scg in aws_security_group.default : scg.name => scg.id if length(aws_security_group.default) != 0 }
    scg_ids = { for key, scg in aws_security_group.default : key => scg.id if length(aws_security_group.default) != 0 }
}

resource "aws_security_group_rule" "sgr_cidr_blocks" {
    for_each                    = {for sgr in var.Security_Group_Rule : "${sgr.SecurityGroup}_${sgr.PortRange}_${sgr.Source}" => sgr
                                   if length(var.Security_Group_Rule) != 0 && can(regex("[0-9]+.[0-9]+.[0-9]+.[0-9]+/[0-9]+", sgr.Source)) == true  }     
    security_group_id           = local.scg_ids[each.value.SecurityGroup]
    type                        = each.value.type
    from_port                   = each.value.Protocol == "icmp" ? -1 : split("-", each.value.PortRange)[0]
    to_port                     = each.value.Protocol == "icmp" ? -1 : can(split("-", each.value.PortRange)[1]) ? split("-", each.value.PortRange)[1] : split("-", each.value.PortRange)[0]
    protocol                    = each.value.Protocol
    cidr_blocks                 = [each.value.Source]
    description                 = each.value.Description
    source_security_group_id    = null
    ipv6_cidr_blocks            = null
    prefix_list_ids             = null
}

resource "aws_security_group_rule" "sgr_source_security_group_id" {
    for_each                    = {for sgr in var.Security_Group_Rule : "${sgr.SecurityGroup}_${sgr.PortRange}_${sgr.Source}" => sgr 
                                   if length(var.Security_Group_Rule) != 0 && can(regex("[0-9a-zA-Z]+-", sgr.Source)) == true } 
    security_group_id           = local.scg_ids[each.value.SecurityGroup]
    type                        = each.value.type
    from_port                   = each.value.Protocol == "icmp" ? -1 : split("-", each.value.PortRange)[0]
    to_port                     = each.value.Protocol == "icmp" ? -1 : can(split("-", each.value.PortRange)[1]) ? split("-", each.value.PortRange)[1] : split("-", each.value.PortRange)[0]
    protocol                    = each.value.Protocol
    source_security_group_id    = local.scg_ids[each.value.Source]
    description                 = each.value.Description
    cidr_blocks                 = null
    ipv6_cidr_blocks            = null
    prefix_list_ids             = null
}