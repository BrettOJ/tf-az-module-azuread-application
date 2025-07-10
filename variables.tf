variable "display_name" {
  description = "The display name for the application."
  type        = string
}

variable "description" {
  description = "A description of the application, as shown to end users."
  type        = string
  default     = null
}

variable "device_only_auth_enabled" {
  description = "Specifies whether this application supports device authentication without a user."
  type        = bool
  default     = false
}

variable "fallback_public_client_enabled" {
  description = "Specifies whether the application is a public client."
  type        = bool
  default     = false
}

variable "feature_tags" {
  description = "A feature_tags block as described in AzureAD docs."
  type = object({
    custom_single_sign_on = optional(bool)
    enterprise             = optional(bool)
    gallery                = optional(bool)
    hide                   = optional(bool)
  })
  default = null
}

variable "group_membership_claims" {
  description = "Membership claims issued in a token that the app expects."
  type        = set(string)
  default     = null
}

variable "identifier_uris" {
  description = "URIs that uniquely identify the application."
  type        = set(string)
  default     = null
}

variable "logo_image" {
  description = "A base64-encoded logo image for the application."
  type        = string
  default     = null
}

variable "marketing_url" {
  description = "URL of the application's marketing page."
  type        = string
  default     = null
}

variable "notes" {
  description = "User-specified notes relevant for the application."
  type        = string
  default     = null
}

variable "oauth2_post_response_required" {
  description = "Allow POST requests in OAuth 2.0 token requests."
  type        = bool
  default     = false
}

variable "optional_claims" {
  description = "Optional claims configuration."
  type = object({
    access_token = optional(list(object({
      name                 = string
      source               = optional(string)
      essential            = optional(bool)
      additional_properties = optional(list(string))
    })))
    id_token = optional(list(object({
      name                 = string
      source               = optional(string)
      essential            = optional(bool)
      additional_properties = optional(list(string))
    })))
    saml2_token = optional(list(object({
      name                 = string
      source               = optional(string)
      essential            = optional(bool)
      additional_properties = optional(list(string))
    })))
  })
  default = null
}

variable "owners" {
  description = "Set of object IDs of users or service principals to own the app."
  type        = set(string)
  default     = null
}

variable "password" {
  description = "Password block for the application."
  type = object({
    display_name = string
    end_date     = optional(string)
    start_date   = optional(string)
  })
  default = null
}

variable "prevent_duplicate_names" {
  description = "Return error if an app with the same name already exists."
  type        = bool
  default     = false
}

variable "privacy_statement_url" {
  description = "URL of the application's privacy statement."
  type        = string
  default     = null
}

variable "public_client" {
  description = "Public client configuration."
  type = object({
    redirect_uris = set(string)
  })
  default = null
}

variable "required_resource_access" {
  description = "OAuth2 and app role permissions the app requires."
  type = list(object({
    resource_app_id = string
    resource_access = list(object({
      id   = string
      type = string # "Role" or "Scope"
    }))
  }))
  default = []
}

variable "service_management_reference" {
  description = "Reference to app context in service/asset management DB."
  type        = string
  default     = null
}

variable "sign_in_audience" {
  description = "Supported Microsoft account types."
  type        = string
  default     = "AzureADMyOrg"
}

variable "single_page_application" {
  description = "Single Page App redirect URIs."
  type = object({
    redirect_uris = set(string)
  })
  default = null
}

variable "support_url" {
  description = "URL of the application's support page."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to the application."
  type        = set(string)
  default     = null
}

variable "template_id" {
  description = "ID for templated app from Azure AD Gallery."
  type        = string
  default     = null
}

variable "terms_of_service_url" {
  description = "URL of the application's terms of service."
  type        = string
  default     = null
}

variable "web" {
  description = "Web application configuration."
  type = object({
    homepage_url = optional(string)
    logout_url   = optional(string)
    redirect_uris = optional(set(string))
    implicit_grant = optional(object({
      access_token_issuance_enabled = optional(bool)
      id_token_issuance_enabled     = optional(bool)
    }))
  })
  default = null
}

variable "app_role" {
  description = "List of application roles."
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
  description = "API configuration block."
  type = object({
    known_client_applications    = optional(set(string))
    mapped_claims_enabled        = optional(bool)
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
