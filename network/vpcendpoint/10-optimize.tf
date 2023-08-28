locals {
    Share_Middle_Name = var.Share_Middle_Name
    VPC_Endpoint_Interface_Optimize = flatten([for endpoint_interface in var.VPC_Endpoint_Interface : [for service in endpoint_interface.service : {
        net_env             = endpoint_interface.net_env
        vpc_identifier      = endpoint_interface.vpc_identifier
        sub_identifiers     = endpoint_interface.sub_identifiers
        scg_identifiers     = endpoint_interface.scg_identifiers
        identifier          = service.identifier
        name_prefix         = service.name_prefix
        service_name        = service.service_name
        private_dns_enabled = service.private_dns_enabled
        tags                = service.tags
    }] if length(var.VPC_Endpoint_Interface) != 0])
}