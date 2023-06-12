#### AWS Sagemaker Notebook Instance ############################################################################################
resource "aws_sagemaker_notebook_instance" "default" {
    for_each        = { for ni in var.NotebookInstance : join("-", ["ni", local.Share_Middle_Name, ni.net_env, ni.name_prefix]) => ni }
    name            = each.key
    role_arn        = local.role_list[each.value.role_name].arn
    instance_type   = each.value.instance_type
    subnet_id       = each.value.sub_identifier != null ? lookup(var.sub_id, join("-", [each.value.net_env, each.value.sub_identifier]), null) : null
    security_groups = each.value.scg_identifier != null ? [for scg_identifier in each.value.scg_identifier : lookup(var.scg_id, join("-", [each.value.net_env, scg_identifier]), null)] : null
}