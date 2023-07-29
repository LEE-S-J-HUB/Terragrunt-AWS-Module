#### Share Variable 
variable "Share_Middle_Name" {
    description = "Name Tags Middle Name(*Ex : join('-', ['vpc', var.Share_Middle_Name, each.value.name_prefix]))"
    type        = string
}

variable "sub_id" {
    description = "The id of the Subnet"
    type    = map(string)
}

variable "eks_cluster" {
    type    = list(object({
        identifier              = string
        sub_identifiers         = list(string)
        role_arn                = string
        version                 = string
        endpoint_public_access  = optional(bool, true)
        endpoint_private_access = optional(bool, false)
        public_access_cidrs     = optional(list(string), ["0.0.0.0/0", ])
        tags                    = optional(map(string), null)
    }))
}