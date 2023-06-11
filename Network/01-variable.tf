#### Share Variable 
variable "Share_Middle_Name" {
    description = "Name Tags Middle Name(*Ex : join('-', ['vpc', var.Share_Middle_Name, each.value.name_prefix]))"
    type        = string
}

variable "Network" {
    description = "Create Resource : VPC, Subnet, Route Tables(Subnet Associations), NAT Gateway"
    type    = list(object({
        net_env                 = string
        identifier              = string
        name_prefix             = string
        cidr_block              = string
        igw_enable              = optional(bool, false)
        enable_dns_hostnames    = optional(bool, true)
        enable_dns_support      = optional(bool, true)
        instance_tenancy        = optional(string, "default")
        tags                    = optional(map(string), null)
        ## Create Subnet Configure Attribute
        subnets                 = optional(list(object({
            identifier              = optional(string, null)
            name_prefix             = optional(string, null)
            vpc_name_prefix         = optional(string, null)
            availability_zone       = optional(string, null)
            cidr_block              = optional(string, null)
            tags                    = optional(map(string), null)
        })), null)
        ## Create Route Table && Route Table Assocation Subnet Configure Attribute
        route_tables            = optional(list(object({
            identifier                      = optional(string, null)
            name_prefix                     = optional(string, null)
            association_subnet_identifier   = optional(list(string), null)
            tags                            = optional(map(string), null)
        })), null)
        ## Create NAT_Gateway Configure Attribute
        nat_gateway             = optional(list(object({
            identifier              = optional(string, null)
            #* aws_eip Attribute */ 
            eip_name_prefix         = optional(string, null)
            vpc                     = optional(bool, true)
            #* aws_net_gateway Attribute */
            sub_identifier          = optional(string, null)
            ngw_name_prefix         = optional(string, null)
            connectivity_type       = optional(string, "public")
            private_ip              = optional(string, null)         
            #* Share Attribute */
            tags                    = optional(map(string), null)
        })),null)             
    }))
}