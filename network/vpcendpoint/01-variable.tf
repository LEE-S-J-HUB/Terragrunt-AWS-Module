variable "Share_Middle_Name" {
    type        = string
}

variable "vpc_id" {
    description = "The id of the VPC"
    type        = map(string)
}

variable "sub_id" {
    description = "The id of the Subnet"
    type        = map(string)
}

variable "rtb_id" {
    description = "The id of the Route Table"
    type        = map(string)
}

variable "scg_id" {
    description = "The id of the Security Group"
    type        = map(string)
}

variable "VPC_Endpoint_Gateway" {
    type    = list(object({
        net_env             = optional(string, null)
        vpc_identifier      = optional(string, null)
        rtb_identifiers     = optional(list(string), null)
        identifier          = optional(string, null)
        name_prefix         = optional(string, null)
        service_name        = optional(string, null)
        tags                = optional(map(string), null)
    }))
}

variable "VPC_Endpoint_Interface" {
    type    = list(object({
        net_env                 = optional(string, null)
        vpc_identifier          = optional(string, null)
        sub_identifiers         = optional(list(string), null)
        scg_identifiers         = optional(list(string), null)
        service                 = optional(list(object({
            identifier          = optional(string, null)
            name_prefix             = optional(string, null)
            service_name            = optional(string, null)
            private_dns_enabled     = optional(bool, true)
            tags                    = optional(map(string), null)
        })), null)
    }))
}