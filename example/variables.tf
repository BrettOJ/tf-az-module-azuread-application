variable "display_name" {
  description = "Display name for the Azure AD application."
  type        = string
}

variable "description" {
  type        = string
  default     = null
}

variable "device_only_auth_enabled" {
  type    = bool
  default = false
}

variable "fallback_public_client_enabled" {
  type    = bool
  default = false
}

variable "feature_tags" {
  type = object({
    custom_single_sign_on = optional(bool)
    enterprise             = optional(bool)
    gallery                = optional(bool)
    hide                   = optional(bool)
  })
  default = null
}

variable "group_membership_claims" {
  type    = set(string)
  default = null
}

variable "identifier_uris" {
  type    = set(string)
  default = null
}

variable "logo_image" {
  type    = string
  default = null
}

variable "marketing_url" {
  type    = string
  default = null
}

variable "notes" {
  type    = string
  default = null
}

variable "oauth2_post_response_required" {
  type    = bool
  default = false
}

variable "optional_claims" {
  type = object({
    access_token = optional(list(object({
      name                  = string
      source                = optional(string)
      essential             = optional(bool)
      additional_properties = optional(list(string))
    })))
    id_token = optional(list(object({
      name                  = string
      source                = optional(string)
      essential             = optional(bool)
      additional_properties = optional(list(string))
    })))
    saml2_token = optional(list(object({
      name                  = string
      source                = optional(string)
      essential             = optional(bool)
      additional_properties = optional(list(string))
    })))
  })
  default = null
}

variable "owners" {
  type    = set(string)
  default = null
}

variable "password" {
  type = object({
    display_name = string
    start_date   = optional(string)
    end_date     = optional(string)
  })
  default = null
}

variable "prevent_duplicate_names" {
  type    = bool
  default = false
}

variable "privacy_statement_url" {
  type    = string
  default = null
}

variable "public_client" {
  type = object({
    redirect_uris = set(string)
  })
  default = null
}

variable "required_resource_access" {
  type = list(object({
    resource_app_id = string
    resource_access = list(object({
      id   = string
      type = string
    }))
  }))
  default = []
}

variable "service_management_reference" {
  type    = string
  default = null
}

variable "sign_in_audience" {
  type    = string
  default = "AzureADMyOrg"
}

variable "single_page_application" {
  type = object({
    redirect_uris = set(string)
  })
  default = null
}

variable "support_url" {
  type    = string
  default = null
}

variable "tags" {
  type    = set(string)
  default = null
}

variable "template_id" {
  type    = string
  default = null
}

variable "terms_of_service_url" {
  type    = string
  default = null
}

variable "web" {
  type = object({
    homepage_url  = optional(string)
    logout_url    = optional(string)
    redirect_uris = optional(set(string))
    implicit_grant = optional(object({
      access_token_issuance_enabled = optional(bool)
      id_token_issuance_enabled     = optional(bool)
    }))
  })
  default = null
}

variable "app_role" {
  type = list(object({
    allowed_member_types = list(string)
    description           = string
    display_name          = string
    enabled               = optional(bool)
    id                    = string
    value                 = optional(string)
  }))
  default = []
}

variable "api" {
  type = object({
    known_client_applications     = optional(set(string))
    mapped_claims_enabled         = optional(bool)
    requested_access_token_version = optional(number)
    oauth2_permission_scope = optional(list(object({
      admin_consent_description  = string
      admin_consent_display_name = string
      enabled                    = optional(bool)
      id                         = string
      type                       = optional(string)
      user_consent_description   = optional(string)
      user_consent_display_name  = optional(string)
      value                      = optional(string)
    })))
  })
  default = null
}
