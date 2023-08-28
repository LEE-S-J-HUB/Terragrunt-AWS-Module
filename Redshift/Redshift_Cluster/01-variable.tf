#### Share Variable 
variable "Share_Middle_Name" {
    description = "Name Tags Middle Name(*EX : join('-', ['vpc', var.Share_Middle_Name, each.value.name_prefix]))"
    type        = string
    default     = "an2-sha-dev"
}

variable "scg_id" {
    type        = map(string)
}

variable "name_prefix" {
    description = "Resource Identifier"
    type        = string
    default     = "temp"    
}

variable "net_env" {
    description = "Network Environment"
    type        = string
    default     = "dev"
}

variable "database_name" {
    description = "The name of the first database to be created when the cluster is created."
    type        = string
    default     = "dev"
}

variable "master_username" {
    description = "Username for the master DB user."
    type        = string
    default     = "awsuser"
}

variable "master_password" {
    description = "Password for the master DB user."
    type        = string
    default     = null
    sensitive   = true
    validation {
        condition       = var.master_password != null
        error_message   = "The master_password is a required field."
    }   
}

variable "port" {
    description = "The port number on which the cluster accepts incoming connections."
    type        = number
    default     = 5439
}

variable "vpc_security_group_identifier" {
    description = "A list of Virtual Private Cloud (VPC) security groups to be associated with the cluster."
    type        = list(string)
    default     = []
}

variable "publicly_accessible" {
    description = "If true, the cluster can be accessed from a public network. Default is true."
    type        = bool
    default     = true
}

variable "cluster_subnet_group_name" {
    description = "The name of a cluster subnet group to be associated with this cluster."
    type        = string
    default     = null
}

variable "cluster_type" {
    description = "The cluster type to use. Either single-node or multi-node."
    type        = string
    default     = "single-node"
}

variable "node_type" {
    description = "The node type to be provisioned for the cluster."
    type        = string
    default     = "dc2.large"
}

variable "number_of_nodes" {
    type        = number
    default     = 1
}   

variable "skip_final_snapshot" {
    description = "Determines whether a final snapshot of the cluster is created before Amazon Redshift deletes the cluster."
    type        = bool 
    default     = true
}

variable "allow_version_upgrade" {
    description = "major version upgrades can be applied during the maintenance window to the Amazon Redshift engine that is running on the cluster."
    type        = bool
    default     = false
}

variable "logs_enable" {
    type        = bool
    default     = false
}

variable "log_destination_type" {
    type        = string
    default     = null
}

variable "bucket_name" {
    type        = string
    default     = null
}

variable "s3_key_prefix" {
    type        = string
    default     = null
}

variable "log_exports" {
    type        = list(string)
    default     = ["connectionlog", "userlog"]
}

variable "availability_zone_relocation_enabled" {
    type        = bool
    default     = false
}

variable "enhanced_vpc_routing" {
    type        = bool
    default     = false
}

# variable "Redshift" {
#     description = "Create Redshift"
#     type = list(object({
#         ## description = "Resource Identifier"
#         name_prefix                     = optional(string, "temp")
#         ## 
#         net_env                         = optional(string, "dmz")
#         ## description = "The name of the first database to be created when the cluster is created."
#         database_name                   = optional(string, "dev")
#         ## description = "Username for the master DB user."
#         master_username                 = optional(string, "awsuser")
#         ## description = "Password for the master DB user."
#         master_password                 = string
#         ## description = "The port number on which the cluster accepts incoming connections."
#         port                            = optional(number, 5439)
#         ## description = "A list of Virtual Private Cloud (VPC) security groups to be associated with the cluster."
#         vpc_security_group_identifier   = optional(list(string), [])
#         ## description = "The name of a cluster subnet group to be associated with this cluster."
#         cluster_subnet_group_name       = optional(string, null)
#         ## description = "The node type to be provisioned for the cluster."
#         node_type                       = optional(string, "dc2.large")
#         ## description = "The cluster type to use. Either single-node or multi-node."
#         cluster_type                    = optional(string, "single-node")
#         ## description = "Determines whether a final snapshot of the cluster is created before Amazon Redshift deletes the cluster."
#         skip_final_snapshot             = optional(bool, true)
#         ## description = "major version upgrades can be applied during the maintenance window to the Amazon Redshift engine that is running on the cluster."
#         allow_version_upgrade           = optional(bool, false)
#         number_of_nodes                 = optional(number, 1)


        
#         logs_enable                     = optional(bool, false)
#         log_destination_type            = optional(string, null)
#         bucket_name                     = optional(string, null)
#         s3_key_prefix                   = optional(string, null)
#         log_exports                     = optional(list(string), ["connectionlog", "userlog"])


#     }))
# }
