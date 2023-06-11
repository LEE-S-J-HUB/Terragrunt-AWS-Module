# Terraform AWS Module - LEE SEUNG JOON : Network

## Nmaing 
resource key        : "${net_env}-${name_prefix}"

resource name_tag   : "Service-${Share_Middle_Name}-{net_env}-${name_prefix}"

## Example Template
```HCL
module "Network" {
    source = "../../../Terraform-AWS-Module/Network"
    Share_Middle_Name = local.Share_Middle_Name
    Network                 = [
        {   
            net_env = "dev", identifier = "01", name_prefix = "01", cidr_block = "10.100.0.0/23", igw_enable = true 
            subnets          = [                
                {   identifier = "lb-01a",  name_prefix = "lb-01a",  availability_zone  = "a", cidr_block = "10.100.0.0/27"     },
                {   identifier = "lb-01c",  name_prefix = "lb-01c",  availability_zone  = "c", cidr_block = "10.100.0.32/27"    },
                {   identifier = "web-01a", name_prefix = "web-01a", availability_zone  = "a", cidr_block = "10.100.0.64/26"    },
                {   identifier = "web-01c", name_prefix = "web-01c", availability_zone  = "c", cidr_block = "10.100.0.128/26"   },
            ]
            route_tables     = [
                {   identifier = "lb",      name_prefix = "lb",     association_subnet_identifier = ["lb-01a", "lb-01c"]    },
                {   identifier = "web",     name_prefix = "web",    association_subnet_identifier = ["web-01a", "web-01c"]  },
            ]
        },
    ]
}
```