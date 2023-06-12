#### Share Variable 
variable "Share_Middle_Name" {
    description = "Name Tags Middle Name(*Ex : join('-', ['vpc', var.Share_Middle_Name, each.value.name_prefix]))"
    type        = string
}

variable "sub_id" {
    type        = map(string)
}

variable "scg_id" {
    type        = map(string)
}


variable "NotebookInstance" {
    description = "Create Resource : Sagemaker Notebook Instance"
    type    = list(object({
        net_env                 = string
        name_prefix             = string
        role_name               = string
        platform_identifier     = optional(string, "notebook-al2-v2")
        instance_type           = optional(string, "ml.t3.medium")
        volume_size             = optional(number, 5)
        direct_internet_access  = optional(string, "Enabled")
        root-access             = optional(string, "Enabled")
        sub_identifier          = optional(string, null)
        scg_identifier          = optional(list(string), [null])           
    }))
}