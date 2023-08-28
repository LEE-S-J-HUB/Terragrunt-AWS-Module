output "rs_endpoint" {
    description = "The Endpoint of the Redshift" 
    value = { for key, value in aws_redshift_cluster.default : key => value.endpoint }   
}

output "rs_port" {
    description = "The port of the Redshift" 
    value = { for key, value in aws_redshift_cluster.default : key => value.port }
}

output "re_logs_enable" {
    value = { for key, value in aws_redshift_cluster.default : key => value.logging[0].enable }
}

output "re_publicly_accessible" {
    description = "The publicly_accessible of the Redshift" 
    value = { for key, value in aws_redshift_cluster.default : key => value.publicly_accessible }
}

output "rs_availability_zone_relocation_enabled" {
    description = "The availability_zone_relocation_enabled of the Redshift" 
    value = { for key, value in aws_redshift_cluster.default : key => value.availability_zone_relocation_enabled }
}

output "rs_enhanced_vpc_routing" {
    description = "The enhanced_vpc_routing of the Redshift" 
    value = { for key, value in aws_redshift_cluster.default : key => value.enhanced_vpc_routing }
}