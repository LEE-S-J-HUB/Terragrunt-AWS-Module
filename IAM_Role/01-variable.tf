#### Share Variable 
variable "Share_Middle_Name" {
    type        = string
}

variable "Role" {
    type    = list(object({
        name_prefix                             = string
        assume_role_policy                      = string
        attachment_policy                       = optional(list(string), null)
        description                             = optional(string, "Role")
        # create_instance_profile                 = optional(bool, false)
        tags                                    = optional(map(string), null)
    }))
}