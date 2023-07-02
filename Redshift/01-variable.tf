#### Share Variable 
variable "Share_Middle_Name" {
    description = "Name Tags Middle Name(*EX : join('-', ['vpc', var.Share_Middle_Name, each.value.name_prefix]))"
    type        = string
    default     = "an2-sha-dev"
}

variable "scg_id" {
    type        = map(string)
}

variable "Redshift" {
    description = "Create Redshift"
    type = list(object({
        ## description = "Resource Identifier"
        name_prefix                     = optional(string, "temp")
        ## description = "Network Environment"
        net_env                         = optional(string, "dmz")
        ## description = "The name of the first database to be created when the cluster is created."
        database_name                   = optional(string, "dev")
        ## description = "Username for the master DB user."
        master_username                 = optional(string, "awsuser")
        ## description = "Password for the master DB user."
        master_password                 = string
        ## description = "The port number on which the cluster accepts incoming connections."
        port                            = optional(number, 5439)
        ## description = "A list of Virtual Private Cloud (VPC) security groups to be associated with the cluster."
        vpc_security_group_identifier   = optional(list(string), [])
        ## description = "The name of a cluster subnet group to be associated with this cluster."
        cluster_subnet_group_name       = optional(string, null)
        ## description = "The node type to be provisioned for the cluster."
        node_type                       = optional(string, "dc2.large")
        ## description = "The cluster type to use. Either single-node or multi-node."
        cluster_type                    = optional(string, "single-node")
        ## description = "Determines whether a final snapshot of the cluster is created before Amazon Redshift deletes the cluster."
        skip_final_snapshot             = optional(bool, true)
        
    }))
}
