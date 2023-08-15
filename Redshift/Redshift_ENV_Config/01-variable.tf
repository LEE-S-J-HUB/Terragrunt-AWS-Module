#### Share Variable 
variable "Share_Middle_Name" {
    description = "Name Tags Middle Name(*Ex : join('-', ['vpc', var.Share_Middle_Name, each.value.name_prefix]))"
    type        = string
}

variable "sub_id" {
    type        = map(string)
}

variable "Redshift_Subnet_Groups" {
    description = "Create Resource : Redshift Subnet Group"
    type    = list(object({
        net_env                 = string
        identifier              = string
        name_prefix             = string
        sub_identifier          = optional(list(string), [null])
    }))
}

variable "Redshift_Parameter_Groups" {
    description = "Create Resource : Redshift Parameter Group"
    type    = list(object({
        net_env                 = string
        identifier              = string
        name_prefix             = string
        family                  = optional(string, null)
    }))    
}