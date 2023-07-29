resource "aws_vpc_endpoint" "VPC_Endpoint_Gateway" {
  for_each          = { for vpce in var.VPC_Endpoint_Gateway : join("-", [vpce.net_env, vpce.identifier]) => vpce if length(var.VPC_Endpoint_Gateway) != 0}
  vpc_endpoint_type = "Gateway"
  service_name      = each.value.service_name
  vpc_id            = var.vpc_id[join("-", [each.value.net_env, each.value.vpc_identifier])]
  route_table_ids   = [for rtb_identifier in each.value.rtb_identifier : var.rtb_id[join("-", [each.value.net_env, rtb_identifier])]]
  tags              = merge(each.value.tags, {
                                "Name" = join("-", ["vpce", local.Share_Middle_Name, each.value.net_env, each.value.name_prefix]) 
                            })
}

resource "aws_vpc_endpoint" "VPC_Endpoint_Interface" {
  for_each            = { for vpce in local.VPC_Endpoint_Interface_Optimize : join("-", [vpce.net_env, vpce.identifier]) => vpce if length(local.VPC_Endpoint_Interface_Optimize) != 0}
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = each.value.private_dns_enabled
  service_name        = each.value.service_name
  vpc_id              = var.vpc_id[join("-", [each.value.net_env, each.value.vpc_identifier])]
  subnet_ids          = [for sub_identifier in each.value.sub_identifier : var.sub_id[join("-", [each.value.net_env, sub_identifier])]]
  security_group_ids  = [for scg_identifier in each.value.scg_identifier : var.scg_id[join("-", [each.value.net_env, scg_identifier])]]
  tags                = merge(each.value.tags, {
                                "Name" = join("-", ["vpce", local.Share_Middle_Name, each.value.net_env, each.value.name_prefix]) 
                            })
}
