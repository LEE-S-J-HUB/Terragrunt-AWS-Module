#### Redshift ##########################################################################################################
resource "aws_redshift_cluster" "default" {
    for_each                        = { for rs in var.Redshift : join("-", ["rs", local.Share_Middle_Name, rs.net_env, rs.name_prefix]) => rs }
    cluster_identifier              = each.key
    database_name                   = each.value.database_name
    master_username                 = each.value.master_username
    master_password                 = each.value.master_password
    node_type                       = each.value.node_type
    cluster_type                    = each.value.cluster_type   
    cluster_subnet_group_name       = each.value.cluster_subnet_group_name
    vpc_security_group_ids          = [ for scg_identifier in each.value.vpc_security_group_identifier : var.scg_id[scg_identifier] ] 
    skip_final_snapshot             = each.value.skip_final_snapshot
    timeouts {
        create = "5m"
        update = "10m"
        delete = "5m"
    }
}