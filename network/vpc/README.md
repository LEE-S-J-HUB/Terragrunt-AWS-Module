# Terraform AWS Module - LEE SEUNG JOON : Network

## Nmaing 
resource key        : "${net_env}-${name_prefix}"

resource name_tag   : "Service-${Share_Middle_Name}-{net_env}-${name_prefix}"

## Example Template
```HCL
inputs = {
    Network                 = [
        {   
            net_env = "dmz", identifier = "dmz-01", name_prefix = "01", cidr_block = "10.100.0.0/23", igw_enable = true 
            subnets          = [                
                {   identifier = "dmz-lb-01a",  name_prefix = "lb-01a",  availability_zone  = "a", cidr_block = "10.100.0.0/27"     },
                {   identifier = "dmz-lb-01c",  name_prefix = "lb-01c",  availability_zone  = "c", cidr_block = "10.100.0.32/27"    },
                {   identifier = "dmz-web-01a", name_prefix = "web-01a", availability_zone  = "a", cidr_block = "10.100.0.64/26"    },
                {   identifier = "dmz-web-01c", name_prefix = "web-01c", availability_zone  = "c", cidr_block = "10.100.0.128/26"   },
                {   identifier = "dmz-app-01a", name_prefix = "app-01a", availability_zone  = "a", cidr_block = "10.100.1.0/26"     },
                {   identifier = "dmz-app-01c", name_prefix = "app-01c", availability_zone  = "c", cidr_block = "10.100.1.64/26"    },
                {   identifier = "dmz-db-01a",  name_prefix = "db-01a",  availability_zone  = "a", cidr_block = "10.100.1.128/27"   },
                {   identifier = "dmz-db-01c",  name_prefix = "db-01c",  availability_zone  = "c", cidr_block = "10.100.1.160/27"   },
            ]
            route_tables     = [
                {   identifier = "dmz-lb",      name_prefix = "lb",     association_subnet_identifier = ["dmz-lb-01a", "dmz-lb-01c"]    },
                {   identifier = "dmz-web",     name_prefix = "web",    association_subnet_identifier = ["dmz-web-01a", "dmz-web-01c"]  },
                {   identifier = "dmz-app",     name_prefix = "app",    association_subnet_identifier = ["dmz-app-01a", "dmz-app-01c"]  },
                {   identifier = "dmz-db",      name_prefix = "db",     association_subnet_identifier = ["dmz-db-01a", "dmz-db-01c"]    },
            ]
            nat_gateway     = [
                {   identifier = "dmz-lb-01a",  sub_identifier = "lb-01a",  ngw_name_prefix = "lb-01a", eip_name_prefix = "ngw" },
            ]
        },
    ]   
}
```