output "endpoint" {
    description = "The Endpoint of the Redshift" 
    value = { for key, value in aws_redshift_cluster.default : key => value.endpoint }   
}

output "port" {
    description = "The port of the Redshift" 
    value = { for key, value in aws_redshift_cluster.default : key => value.port }
}

output "logs_enable" {
    value = { for key, value in aws_redshift_cluster.default : key => value.logging[0].enable }
}

output "log_destination_type" {
    value = { for key, value in aws_redshift_cluster.default : key => value.logging[0].log_destination_type }
}

output "publicly_accessible" {
    description = "The publicly_accessible of the Redshift" 
    value = { for key, value in aws_redshift_cluster.default : key => value.publicly_accessible }
}

output "availability_zone_relocation_enabled" {
    description = "The availability_zone_relocation_enabled of the Redshift" 
    value = { for key, value in aws_redshift_cluster.default : key => value.availability_zone_relocation_enabled }
}

output "enhanced_vpc_routing" {
    description = "The enhanced_vpc_routing of the Redshift" 
    value = { for key, value in aws_redshift_cluster.default : key => value.enhanced_vpc_routing }
}

output "cluster_subnet_group_name" {
    description = "The cluster_subnet_group_name of the Redshift" 
    value = { for key, value in aws_redshift_cluster.default : key => value.cluster_subnet_group_name }
}

output "cluster_parameter_group_name" {
    description = "The cluster_parameter_group_name of the Redshift" 
    value = { for key, value in aws_redshift_cluster.default : key => value.cluster_parameter_group_name }
}