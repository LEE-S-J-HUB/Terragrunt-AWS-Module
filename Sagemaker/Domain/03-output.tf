# output "sagemaker_notebook_instnace" {
#     value = aws_sagemaker_notebook_instance.default[*]
# }

# output "ni_name" {
#     description = "The Name of the Notebook Instance"
#     value = { for key, ni in aws_sagemaker_notebook_instance.default : key => ni.name}
# }


# output "redshift_subnet_group" {
#     value = aws_redshift_subnet_group.default[*]
# }

# output "Redshift_Parameter_Groups" {
#     value = aws_redshift_parameter_group.default[*]
# }


output "sagemaker_domain" {
    value = aws_sagemaker_domain.default[*]
}


output "sagemaker_user_profile" {
    value = aws_sagemaker_user_profile.default[*]
}