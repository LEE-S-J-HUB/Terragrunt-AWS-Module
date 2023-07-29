#### Share Variable 
variable "Share_Middle_Name" {
    description = "Name Tags Middle Name(*Ex : join('-', ['vpc', var.Share_Middle_Name, each.value.name_prefix]))"
    type        = string
}

variable "vpc_id" {
    description = "The id of the VPC"
    type        = map(string)
}

variable "SecurityGroup" {
    type = list(object({
        net_env                 = string
        vpc_identifier          = string
        securitygroup           = optional(list(object({
            identifier              = optional(string, null)
            name_prefix             = optional(string, null)
            description             = optional(string, "Security Group")
            tags                    = optional(map(string), null)
        })), null)
    }))
}

variable "Security_Group_Rule"{
    type = list(object({
        SecurityGroup               = string
        Protocol                    = string
        PortRange                   = string
        Source                      = string
        Description                 = string
        type                        = optional(string, "ingress")
    }))
}