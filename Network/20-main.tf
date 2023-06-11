data "aws_region" "current" {}

### AWS VPC
resource "aws_vpc" "default" {
    for_each                = { for vpc in var.Network : join("-", [vpc.net_env, vpc.identifier]) => vpc }
    cidr_block              = each.value.cidr_block
    enable_dns_hostnames    = each.value.enable_dns_hostnames
    enable_dns_support      = each.value.enable_dns_support
    instance_tenancy        = each.value.instance_tenancy
    tags                    = merge(each.value.tags, {
                                "Name" = join("-", ["vpc", var.Share_Middle_Name, each.value.net_env, each.value.name_prefix]) 
                            })
}
locals {
    vpc_id = { for key, vpc in aws_vpc.default : key => vpc.id if length(aws_vpc.default) != 0 }
}

### AWS Internet Gateway 
resource "aws_internet_gateway" "default" {
    for_each                = { for igw in var.Network : join("-", [igw.net_env, igw.identifier]) => igw if igw.igw_enable == true && length(aws_vpc.default) != 0 }
	vpc_id                  = local.vpc_id["${each.key}"]
    tags                    = merge(each.value.tags, {
                                "Name" = join("-", ["igw", var.Share_Middle_Name, each.value.net_env, each.value.name_prefix]) 
                            })
}

### AWS Subnet
resource "aws_subnet" "default" {
    for_each                = { for sub in local.Subnet_Optimize : join("-", [sub.net_env, sub.identifier]) => sub if length(aws_vpc.default) != 0 && length(local.Subnet_Optimize) != 0 }
    vpc_id                  = local.vpc_id[join("-", [each.value.net_env, each.value.vpc_identifier])]
    availability_zone       = each.value.availability_zone
    cidr_block              = each.value.cidr_block
    tags                    = merge(each.value.tags, {
                                "Name" = join("-", ["sub", var.Share_Middle_Name, each.value.net_env, each.value.name_prefix]) 
                            })
}
locals {
    subnet_id = { for key, subnet in aws_subnet.default : key => subnet.id if length(aws_subnet.default) != 0 }
}
### AWS Route Table 
resource "aws_route_table" "default" {
    for_each                = { for rtb in local.Route_Table_Optimize : join("-", [rtb.net_env, rtb.identifier]) => rtb if length(aws_vpc.default) != 0 && length(local.Route_Table_Optimize) != 0 }
    vpc_id                  = local.vpc_id[join("-", [each.value.net_env, each.value.vpc_identifier])]
    tags                    = merge(each.value.tags, {
                                "Name" = join("-", ["rtb", var.Share_Middle_Name, each.value.net_env, each.value.name_prefix]) 
                            })
}
locals {
    route_table_id = { for key, route_table in aws_route_table.default : key => route_table.id if length(aws_route_table.default) != 0 }
}

### AWS Route Table Assocation Subnet
resource "aws_route_table_association" "default" {
    for_each                = { for rta in local.Route_Taable_Association_Optimize : join("-", [rta.net_env, rta.identifier, rta.sub_identifier]) => rta if length(aws_route_table.default) != 0 && length(local.Route_Taable_Association_Optimize) != 0 }
    route_table_id          = local.route_table_id[join("-", [each.value.net_env, each.value.identifier])]
    subnet_id               = local.subnet_id[join("-", [each.value.net_env, each.value.sub_identifier])]
}



### NAT GATEWAY ################################################################################################################
resource "aws_eip" "public_nat_gateway_eip" {
    for_each                = { for NAT_Gateway in local.NAT_Gateway_Optimize : join("-", [NAT_Gateway.net_env, NAT_Gateway.identifier]) => NAT_Gateway 
                                if length(compact([NAT_Gateway.sub_identifier, NAT_Gateway.eip_name_prefix, NAT_Gateway.ngw_name_prefix ])) == 3 && NAT_Gateway.connectivity_type == "public"}
    vpc                     = each.value.vpc
    tags                    = merge(each.value.tags, {
                                "Name" = join("-", ["eip", var.Share_Middle_Name, each.value.eip_name_prefix]) 
                            })
}
locals {
    eip_id = { for key, eip in aws_eip.public_nat_gateway_eip : key => eip.id if length(aws_eip.public_nat_gateway_eip) != 0 }
}

resource "aws_nat_gateway" "public_nat_gateway" {
    for_each                = { for NAT_Gateway in local.NAT_Gateway_Optimize : join("-", [NAT_Gateway.net_env, NAT_Gateway.identifier]) => NAT_Gateway 
                                if length(compact([NAT_Gateway.sub_identifier, NAT_Gateway.eip_name_prefix, NAT_Gateway.ngw_name_prefix ])) == 3 && NAT_Gateway.connectivity_type == "public" && length(aws_eip.public_nat_gateway_eip) != 0 }
    subnet_id               = local.subnet_id[join("-", [each.value.net_env, each.value.sub_identifier])]
    allocation_id           = local.eip_id[join("-", [each.value.net_env, each.value.identifier])]
    connectivity_type       = each.value.connectivity_type
    private_ip              = each.value.private_ip
    tags                    = merge(each.value.tags, {
                                "Name" = join("-", ["ngw", var.Share_Middle_Name, each.value.ngw_name_prefix]) 
                            })
}

resource "aws_nat_gateway" "private_nat_gateway" {
    for_each                = { for NAT_Gateway in local.NAT_Gateway_Optimize : join("-", [NAT_Gateway.net_env, NAT_Gateway.identifier]) => NAT_Gateway 
                                if length(compact([NAT_Gateway.sub_identifier, NAT_Gateway.ngw_name_prefix ])) == 2 && NAT_Gateway.connectivity_type == "private"}
    subnet_id               = local.subnet_id[join("-", [each.value.net_env, each.value.sub_identifier])]
    connectivity_type       = each.value.connectivity_type
    private_ip              = each.value.private_ip
    tags                    = merge(each.value.tags, {
                                "Name" = join("-", ["ngw", var.Share_Middle_Name, each.value.ngw_name_prefix]) 
                            })
}