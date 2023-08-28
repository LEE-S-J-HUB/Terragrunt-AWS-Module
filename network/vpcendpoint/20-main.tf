resource "aws_vpc_endpoint" "VPC_Endpoint_Gateway" {
  for_each          = { for vpce in var.VPC_Endpoint_Gateway : vpce.identifier => vpce if length(var.VPC_Endpoint_Gateway) != 0}
  vpc_endpoint_type = "Gateway"
  service_name      = each.value.service_name
  vpc_id            = var.vpc_id[each.value.vpc_identifier]
  route_table_ids   = [for rtb_identifier in each.value.rtb_identifiers : var.rtb_id[rtb_identifier]]
  tags              = merge(each.value.tags, {
                                "Name" = join("-", ["vpce", local.Share_Middle_Name, each.value.net_env, each.value.name_prefix]) 
                            })
}

resource "aws_vpc_endpoint" "VPC_Endpoint_Interface" {
  for_each            = { for vpce in local.VPC_Endpoint_Interface_Optimize : vpce.identifier => vpce if length(local.VPC_Endpoint_Interface_Optimize) != 0}
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = each.value.private_dns_enabled
  service_name        = each.value.service_name
  vpc_id              = var.vpc_id[each.value.vpc_identifier]
  subnet_ids          = [for sub_identifier in each.value.sub_identifiers : var.sub_id[sub_identifier]]
  security_group_ids  = [for scg_identifier in each.value.scg_identifiers : var.scg_id[scg_identifier]]
  tags                = merge(each.value.tags, {
                                "Name" = join("-", ["vpce", local.Share_Middle_Name, each.value.net_env, each.value.name_prefix]) 
                            })
}
