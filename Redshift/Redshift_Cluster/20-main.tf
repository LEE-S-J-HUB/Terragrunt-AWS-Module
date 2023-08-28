#### Redshift ##########################################################################################################

resource "aws_redshift_cluster" "default" {
    for_each                                = toset([join("-", ["rs", local.Share_Middle_Name, var.net_env, var.name_prefix])])
    cluster_identifier                      = each.key
    database_name                           = var.database_name
    master_username                         = var.master_username
    master_password                         = var.master_password
    port                                    = var.port
    publicly_accessible                     = var.publicly_accessible
    node_type                               = var.node_type
    number_of_nodes                         = var.number_of_nodes
    cluster_type                            = var.cluster_type   
    cluster_subnet_group_name               = var.cluster_subnet_group_name
    cluster_parameter_group_name            = var.cluster_parameter_group_name
    vpc_security_group_ids                  = [ for scg_identifier in var.vpc_security_group_identifier : var.scg_id[scg_identifier] ] 
    skip_final_snapshot                     = var.skip_final_snapshot
    allow_version_upgrade                   = var.allow_version_upgrade
    availability_zone_relocation_enabled    = var.availability_zone_relocation_enabled
    enhanced_vpc_routing                    = var.enhanced_vpc_routing
    logging {
        enable                              = var.logs_enable
        log_destination_type                = var.logs_enable ? var.log_destination_type : null
        bucket_name                         = alltrue([var.logs_enable, var.log_destination_type == "s3"]) ? var.bucket_name : null
        s3_key_prefix                       = alltrue([var.logs_enable, var.log_destination_type == "s3"]) ? var.s3_key_prefix : null
        log_exports                         = alltrue([var.logs_enable, var.log_destination_type == "cloudwatch"]) ? var.log_exports : null
    }
    timeouts {
        create = "5m"
        update = "20m"
        delete = "5m"
    }
}

