output "scg_id" {
    description = "The id of the Security Group"
    value = { for k,scg in aws_security_group.default : k => scg.id }
}

output "aws_seuciry_group_rule" {
    value       = { for scg_key, scg in aws_security_group.default : "${scg_key}(${scg.name})" => flatten([
                        values({ for scgr_key, scgr in aws_security_group_rule.sgr_cidr_blocks : 
                                scgr_key => format("Port : %s, Source : %s, Description : %s", split("_",scgr_key)[1], split("_",scgr_key)[2], scgr.description)
                            if split("_",scgr_key)[0] == scg.name
                        }),
                        values({ for scgr_key, scgr in aws_security_group_rule.sgr_source_security_group_id : 
                                scgr_key => format("Port : %s, Source : %s, Description : %s", split("_",scgr_key)[1], split("_",scgr_key)[2], scgr.description)
                            if split("_",scgr_key)[0] == scg.name
                        })
                    ])
                }
}