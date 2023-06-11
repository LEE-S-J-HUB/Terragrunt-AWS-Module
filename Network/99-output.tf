output "vpc_id" {
    description = "The ID of the VPC"
    value = { for key, vpc in aws_vpc.default : key => vpc.id }
}

output "vpc_cidr" {
    description = "The CIDR block of the VPC"
    value = { for key, vpc in aws_vpc.default : key => vpc.cidr_block }
}

output "vpc_name" {
    description = "The Name block of the VPC"
    value = { for key, vpc in aws_vpc.default : key => vpc.tags["Name"] }
}

output "sub_id" {
    description = "The ID of the Subnet"
    value = { for key, subnet in aws_subnet.default : key => subnet.id }
}

output "subnet_cidr" {
    description = "The CIDR block of the Subnet"
    value = { for key, subnet in aws_subnet.default : key => subnet.cidr_block }
}

output "subnet_name" {
    description = "The Name block of the Subnet"
    value = { for key, subnet in aws_subnet.default : key => subnet.tags["Name"] }
}

output "sub_az" {
    description = "The availability_zone of the Subnet"
    value = { for key, subnet in aws_subnet.default : key => subnet.availability_zone }
}

output "igw_id" {
    description = "The ID of the Internet Gateway"
    value = { for key, internet_gateway in aws_internet_gateway.default : key => internet_gateway.id }
}

output "igw_name" {
    description = "The Name of the Internet Gateway"
    value = { for key, internet_gateway in aws_internet_gateway.default : key => internet_gateway.tags["Name"] }
}

output "rtb_id" {
    description = "The ID of the Route Table"
    value = { for key, Route_Table in aws_route_table.default : key => Route_Table.id }
}


output "rtb_name" {
    description = "The Name of the Route Table"
    value = { for key, Route_Table in aws_route_table.default : key => Route_Table.tags["Name"] }
}

output "rta_list" {
    value = { for key, Route_Table in aws_route_table.default : key => [
            for rta in aws_route_table_association.default : rta.subnet_id if rta.route_table_id == Route_Table.id
        ]
    }
}

output "ngw_id" {
    description = "The ID of the NAT Gateway"
    value = merge({ for key, nat_gateway in aws_nat_gateway.public_nat_gateway : key => nat_gateway.id },
                  { for key, nat_gateway in aws_nat_gateway.private_nat_gateway : key => nat_gateway.id })
}

output "ngw_name" {
    description = "The Name of the NAT Gateway"
    value = merge({ for key, nat_gateway in aws_nat_gateway.public_nat_gateway : key => nat_gateway.tags["Name"] },
                  { for key, nat_gateway in aws_nat_gateway.private_nat_gateway : key => nat_gateway.tags["Name"] })
}

output "ngw_private_ip" {
    description = "The Private IP of the NAT Gateway"
    value = merge({ for key, nat_gateway in aws_nat_gateway.public_nat_gateway : key => nat_gateway.private_ip },
                  { for key, nat_gateway in aws_nat_gateway.private_nat_gateway : key => nat_gateway.private_ip })
}

output "ngw_type" {
    description = "The ConnectivityType of the NAT Gateway"
    value = merge({ for key, nat_gateway in aws_nat_gateway.public_nat_gateway : key => nat_gateway.connectivity_type },
                  { for key, nat_gateway in aws_nat_gateway.private_nat_gateway : key => nat_gateway.connectivity_type })
}

output "eip_id" {
    description = "The ID of the Elastic IP"
    value = { for key, eip in aws_eip.public_nat_gateway_eip : key => eip.id }
}

output "eip_name" {
    description = "The Name of the Elastic IP"
    value = { for key, eip in aws_eip.public_nat_gateway_eip : key => eip.tags["Name"] }
}

output "eip_ip" {
    description = "The Public IP of the NAT Gateway"
    value = { for key, eip in aws_eip.public_nat_gateway_eip : key => eip.public_ip }
}