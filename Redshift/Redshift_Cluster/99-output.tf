# output "sagemaker_notebook_instnace" {
#     value = aws_sagemaker_notebook_instance.default[*]
# }

# output "ni_name" {
#     description = "The Name of the Notebook Instance"
#     value = { for key, ni in aws_sagemaker_notebook_instance.default : key => ni.name}
# }

# output "redshift" {
#     value = aws_redshift_cluster.default[*]
  
# }