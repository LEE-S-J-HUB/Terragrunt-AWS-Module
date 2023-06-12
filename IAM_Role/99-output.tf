output "role" {
    value   = aws_iam_role.default
}

output "role_policy_attachment" {
    value = {for role_key, role in aws_iam_role.default : role_key => values({
        for attachment_key, attachment in aws_iam_role_policy_attachment.default : attachment_key => attachment.policy_arn if attachment.role == role_key
    })}
}

output "role_arn" {
    description = "The arn of the IAM Role"
    value       = { for key, role in aws_iam_role.default : key => role.arn }
}

# output "role_instance_profile" {
#     description = "instance_profile FULL(TEMP)"
#     value       = { for key, instance_profile in aws_iam_instance_profile.default : key => instance_profile }
# }

# output "role_instance_profile_arn" {
#     description = "The arn of the instance profile"
#     value       = { for key, instance_profile in aws_iam_instance_profile.default : key => instance_profile.arn }
# }

# output "role_instance_profile_name" {
#     description = "The name of the instance profile"
#     value       = { for key, instance_profile in aws_iam_instance_profile.default : key => instance_profile.arn }
# }