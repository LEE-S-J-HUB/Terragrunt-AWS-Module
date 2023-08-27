#### Redshift ##########################################################################################################

resource "aws_redshift_cluster" "default" {
    for_each                        = toset([join("-", ["rs", local.Share_Middle_Name, var.net_env, var.name_prefix])])
    cluster_identifier              = each.key
    database_name                   = var.database_name
    master_username                 = var.master_username
    master_password                 = var.master_password
    port                            = var.port
    publicly_accessible             = var.publicly_accessible
    node_type                       = var.node_type
    number_of_nodes                 = var.number_of_nodes
    cluster_type                    = var.cluster_type   
    cluster_subnet_group_name       = var.cluster_subnet_group_name
    vpc_security_group_ids          = [ for scg_identifier in var.vpc_security_group_identifier : var.scg_id[scg_identifier] ] 
    skip_final_snapshot             = var.skip_final_snapshot
    allow_version_upgrade           = var.allow_version_upgrade
    logging {
        enable                  = var.logs_enable
        log_destination_type    = var.logs_enable ? var.log_destination_type : null
        # bucket_name             = alltrue([var.logs_enable, var.log_destination_type == "s3"]) ? vare.bucket_name : null
        # s3_key_prefix           = alltrue([var.logs_enable, var.log_destination_type == "s3"]) ? var.s3_key_prefix : null
        log_exports             = alltrue([var.logs_enable, var.log_destination_type == "cloudwatch"]) ? var.log_exports : null
    }
    timeouts {
        create = "5m"
        update = "10m"
        delete = "5m"
    }
}


# resource "aws_redshift_cluster" "default" {
#     for_each                        = { for rs in var.Redshift : join("-", ["rs", local.Share_Middle_Name, rs.net_env, rs.name_prefix]) => rs }
#     cluster_identifier              = each.key
#     database_name                   = each.value.database_name
#     master_username                 = each.value.master_username
#     master_password                 = each.value.master_password
#     node_type                       = each.value.node_type
#     number_of_nodes                 = each.value.number_of_nodes
#     cluster_type                    = each.value.cluster_type   
#     cluster_subnet_group_name       = each.value.cluster_subnet_group_name
#     vpc_security_group_ids          = [ for scg_identifier in each.value.vpc_security_group_identifier : var.scg_id[scg_identifier] ] 
#     skip_final_snapshot             = each.value.skip_final_snapshot
#     allow_version_upgrade           = each.value.allow_version_upgrade
#     logging {
#         enable                  = each.value.logs_enable
#         log_destination_type    = each.value.logs_enable ? each.value.log_destination_type : null
#         # bucket_name             = alltrue([each.value.logs_enable, each.value.log_destination_type == "s3"]) ? each.value.bucket_name : null
#         # s3_key_prefix           = alltrue([each.value.logs_enable, each.value.log_destination_type == "s3"]) ? each.value.s3_key_prefix : null
#         log_exports             = alltrue([each.value.logs_enable, each.value.log_destination_type == "cloudwatch"]) ? each.value.log_exports : null
#     }
#     timeouts {
#         create = "5m"
#         update = "10m"
#         delete = "5m"
#     }
# }

