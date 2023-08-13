#### Share Variable 
variable "Share_Middle_Name" {
    description = "Name Tags Middle Name(*Ex : join('-', ['vpc', var.Share_Middle_Name, each.value.name_prefix]))"
    type        = string
}
variable "vpc_id" {
    type        = map(string)
}

variable "sub_id" {
    type        = map(string)
}

#### AWS Sagemaker Domain #######################################################################################################
variable "sml_domain" {
    description = "Create Resource : Sagemaker Domain"
    type        = list(object({
        identifier              = string
        net_env                 = string
        name_prefix             = string
        auth_mode               = optional(string, "IAM")
        vpc_identifier          = string
        sub_identifiers         = list(string)
        app_network_access_type = optional(string, "PublicInternetOnly")
        kms_key_id              = optional(string, null)
        ## default_user_settings
        execution_role          = string
        ### canvas_app_settings {
        #### model_register_settings {
        cross_account_model_register_role_arn   = optional(string, null)
        model_register_settings_status          = optional(string, null)
        #### time_series_forecasting_settings
        amazon_forecast_role_arn                = optional(string, null)
        time_series_forecasting_settings_status = optional(string, null)
        #### workspace_settings
        s3_artifact_path                        = optional(string, null)
        s3_kms_key_id                           = optional(string, null)

    }))
}


#### AWS Sagemaker User Profile #################################################################################################
variable "sml_user_profile" {
    description     = "Create Resource : Sagemaker User Profile"   
    type            = list(object({
        identifier                                  = optional(string, null)
        user_profile_name                           = optional(string, null)
        ## user_settings 
        execution_role                              = optional(string, null)
        ### canvas_app_settings 
        #### model_register_settings 
        cross_account_model_register_role_arn       = optional(string, null)
        model_register_settings_status              = optional(string, "DISABLED")
        #### time_series_forecasting_settings
        amazon_forecast_role_arn                    = optional(string, null)
        time_series_forecasting_settings_status     = optional(string, "DISABLED")
        #### workspace_settings
        s3_artifact_path                            = optional(string, null)
        s3_kms_key_id                               = optional(string, null)
    }))
    # validation {
    #     condition       = alltrue([for smlu in var.sml_user_profile : smlu.user_profile_name != null ])
    #     error_message   = "Sagemaker User Profile 생성을 위해서는 user_profile_name 값이 반드시 필요합니다."
    # }
    default = [ {
        identifier          = null
        user_profile_name   = null
    } ]
}