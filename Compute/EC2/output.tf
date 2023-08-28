output "ec2_id" {
    description = "The id of the EC2 Instance"
    value       = {for key, ec2 in aws_instance.this : key => ec2.id }
}

output "ec2_private_ip" {
    description = "The Private IP of the EC2 Instance"
    value       = {for key, ec2 in aws_instance.this : key => ec2.private_ip }
}

output "ec2_eip" {
    description = "The Public IP of the EC2 Instance"
    value       = {for key, ec2 in aws_eip.this : key => ec2.public_ip}
}
