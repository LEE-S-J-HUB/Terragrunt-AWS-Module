locals {
    ## Subnet Object Optimization:
    Subnet_Optimize     = flatten ([ for Network in var.Network : [ for subnet in Network.subnets : {
            net_env             = Network.net_env
            vpc_identifier      = Network.identifier
            identifier          = subnet.identifier
            name_prefix         = subnet.name_prefix
            availability_zone   = "${data.aws_region.current.name}${subnet.availability_zone}"
            cidr_block          = subnet.cidr_block
            tags                = subnet.tags
        }
    ] if Network.identifier != null && length(Network.subnets) != 0 ]) 

    ## Route Table and Route Table Association Subnet Object Optimization :
    Route_Table_Optimize        = flatten([for Network in var.Network : [ for route_table in Network.route_tables : {
            net_env                             = Network.net_env
            vpc_identifier                      = Network.identifier
            identifier                          = route_table.identifier
            name_prefix                         = route_table.name_prefix
            association_subnet_identifier       = route_table.association_subnet_identifier
            tags                                = route_table.tags
    }] if Network.identifier != null && length(Network.route_tables) != 0 ])

    Route_Taable_Association_Optimize   = flatten([ for route_table in local.Route_Table_Optimize : [ for sub_identifier in route_table.association_subnet_identifier : {
        net_env             = route_table.net_env
        identifier          = route_table.identifier
        sub_identifier      = sub_identifier
    }] if length(local.Route_Table_Optimize) != 0 ])

    NAT_Gateway_Optimize = flatten([for Network in var.Network : [for nat_gateway in Network.nat_gateway : {
        net_env             = Network.net_env
        identifier          = nat_gateway.identifier
        eip_name_prefix     = nat_gateway.eip_name_prefix
        ngw_name_prefix     = nat_gateway.ngw_name_prefix
        sub_identifier      = nat_gateway.sub_identifier
        connectivity_type   = nat_gateway.connectivity_type
        private_ip          = nat_gateway.private_ip
        vpc                 = nat_gateway.vpc
        tags                = nat_gateway.tags
    }] if Network.identifier != null && length(Network.nat_gateway) != 0 ])
}