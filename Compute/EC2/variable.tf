variable "Share_Tag" {
    type    = map(map(string))
}

variable "sub_id" {
    description = "The id of the Subnet"
    type        = map(string)
}

variable "sub_az" {
    description = "The availability_zone of the Subnet"
    type        = map(string)
}

variable "scg_id" {
    description = "The id of the Security Group"
    type        = map(string)
}

variable "EC2" {
    type = list(object({
        identifier                  = string
        name_prefix                 = string
        ami                         = string
        instance_type               = string
        sub_identifier              = string
        scg_identifier              = list(string)
        iam_instance_profile        = optional(string, null)
        user_data                   = optional(string, null)
        key_name                    = optional(string, null)
        public_ip                   = optional(bool, false)
        private_ip                  = optional(string, null)
        root_block_device           = list(any)
        ebs_block_device            = optional(list(object({
            ebs_block               = list(any)
            delete_on_termination   = optional(bool, true)
            ebs_device_encrypted    = map(string)
        })), null)            
        tags                        = optional(map(string), null)
    }))
}

variable "enis" {
    type = list(object({
        subnet_id           = string
        private_ips         = list(string)
        security_groups     = list(string)
        instance_identifier = string
        device_index        = number
    }))
}