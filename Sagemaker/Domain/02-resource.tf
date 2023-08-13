
#### AWS Sagemaker Domain #######################################################################################################
resource "aws_sagemaker_domain" "default" {
    for_each    = { for smld in var.sml_domain : smld.identifier => smld }
    domain_name = join("-", ["smld", var.Share_Middle_Name, each.value.net_env, each.value.name_prefix])
    auth_mode   = each.value.auth_mode
    vpc_id      = var.vpc_id[each.value.vpc_identifier]
    subnet_ids  = [ for sub_identifier in each.value.sub_identifiers : var.sub_id[sub_identifier] if length(each.value.sub_identifiers) != 0 ] 
    ### Network and Storage Section
    app_network_access_type = each.value.app_network_access_type
    kms_key_id              = each.value.kms_key_id
    default_user_settings {
        execution_role = each.value.execution_role
        canvas_app_settings {
            model_register_settings {
                cross_account_model_register_role_arn   = each.value.cross_account_model_register_role_arn
                status                                  = each.value.model_register_settings_status
            }
            time_series_forecasting_settings {
                amazon_forecast_role_arn                = each.value.amazon_forecast_role_arn
                status                                  = each.value.time_series_forecasting_settings_status
            }
            workspace_settings {
                s3_artifact_path                        = each.value.s3_artifact_path
                s3_kms_key_id                           = each.value.s3_kms_key_id
            }
        }
    }
}


locals {
    smld_id = length(aws_sagemaker_domain.default[var.sml_domain[0].identifier].id) != 0 ?  aws_sagemaker_domain.default[var.sml_domain[0].identifier].id : null
}
#### AWS Sagemaker User Profile #################################################################################################
resource "aws_sagemaker_user_profile" "default" {
    for_each    = { for smlu in var.sml_user_profile : smlu.identifier => smlu 
                        if alltrue([local.smld_id != null, smlu.identifier != null, smlu.user_profile_name != null])} 
    domain_id               = local.smld_id
    user_profile_name       = each.value.user_profile_name 
    user_settings {
        execution_role      = each.value.execution_role
        canvas_app_settings {
            model_register_settings {
                cross_account_model_register_role_arn       = each.value.cross_account_model_register_role_arn
                status                                      = each.value.model_register_settings_status
            }
            time_series_forecasting_settings {
                amazon_forecast_role_arn                    = each.value.amazon_forecast_role_arn
                status                                      = each.value.time_series_forecasting_settings_status
            }
            workspace_settings {
                s3_artifact_path                            = each.value.s3_artifact_path
                s3_kms_key_id                               = each.value.s3_kms_key_id
            }
        }
    }
}