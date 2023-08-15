#### AWS Redshift Subnet Group ##################################################################################################
resource "aws_redshift_subnet_group" "default" {
    for_each        = { for rsubg in var.Redshift_Subnet_Groups : join("-", [rsubg.net_env, rsubg.name_prefix]) => rsubg }
    name            = join("-", ["subgrp", var.Share_Middle_Name, each.value.net_env, each.value.name_prefix])
    subnet_ids      = each.value.sub_identifier != null ? [ for sub_identifier in each.value.sub_identifier : var.sub_id[join("-", [each.value.net_env, sub_identifier])]] : [null]

}

#### AWS Redshift Parameter Group ###############################################################################################
resource "aws_redshift_parameter_group" "default" {
    for_each        = { for rparg in var.Redshift_Parameter_Groups : join("-", [rparg.net_env, rparg.name_prefix]) => rparg }
    name            = join("-", ["pargrp", var.Share_Middle_Name, each.value.net_env, each.value.name_prefix])
    family          = lookup(each.value, "family", "redshift-1.0")
}