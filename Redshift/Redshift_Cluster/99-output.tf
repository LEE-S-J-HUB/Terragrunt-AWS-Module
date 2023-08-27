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
    value = { for key, value in aws_redshift_cluster.default : key => value.publicly_accessible }
}