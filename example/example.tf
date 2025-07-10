provider "azuread" {
  # Use default settings or configure as needed
}

module "azuread_app" {
  source = "./modules/azuread_app" # Adjust path as needed

  display_name                   = "example-app"
  description                    = "Example Azure AD Application"
  device_only_auth_enabled       = false
  fallback_public_client_enabled = false

  feature_tags = {
    custom_single_sign_on = true
    enterprise             = true
    gallery                = false
    hide                   = false
  }

  group_membership_claims = ["SecurityGroup"]

  identifier_uris = ["api://example-app"]

  logo_image = filebase64("logo.png") # Ensure logo.png exists in your repo

  marketing_url = "https://example.com/marketing"
  notes         = "App created via Terraform"
  oauth2_post_response_required = true

  optional_claims = {
    access_token = [
      {
        name                  = "upn"
        source                = null
        essential             = true
        additional_properties = ["include_externally_authenticated_upn"]
      }
    ]
    id_token = [
      {
        name                  = "email"
        source                = null
        essential             = true
        additional_properties = ["emit_as_roles"]
      }
    ]
    saml2_token = []
  }

  owners = [
    "00000000-0000-0000-0000-000000000000" # Replace with actual object ID
  ]

  password = {
    display_name = "example-secret"
    start_date   = "2025-07-10T00:00:00Z"
    end_date     = "2026-07-10T00:00:00Z"
  }

  prevent_duplicate_names = true
  privacy_statement_url   = "https://example.com/privacy"

  public_client = {
    redirect_uris = [
      "https://localhost:3000/callback"
    ]
  }

  required_resource_access = [
    {
      resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph
      resource_access = [
        {
          id   = "df021288-bdef-4463-88db-98f22de89214" # e.g., Directory.Read.All
          type = "Role"
        }
      ]
    }
  ]

  service_management_reference = "SMDB-REF-001"

  sign_in_audience = "AzureADMyOrg"

  single_page_application = {
    redirect_uris = [
      "https://example.com/spa"
    ]
  }

  support_url        = "https://example.com/support"
  tags               = ["env:dev", "team:platform"]
  template_id        = null
  terms_of_service_url = "https://example.com/tos"

  web = {
    homepage_url  = "https://example.com"
    logout_url    = "https://example.com/logout"
    redirect_uris = ["https://example.com/redirect"]

    implicit_grant = {
      access_token_issuance_enabled = true
      id_token_issuance_enabled     = true
    }
  }

  app_role = [
    {
      allowed_member_types = ["User"]
      description           = "Read access"
      display_name          = "Reader"
      enabled               = true
      id                    = "11111111-1111-1111-1111-111111111111" # Use random_uuid if needed
      value                 = "Reader"
    }
  ]

  api = {
    known_client_applications     = ["22222222-2222-2222-2222-222222222222"]
    mapped_claims_enabled         = true
    requested_access_token_version = 2

    oauth2_permission_scope = [
      {
        admin_consent_description  = "Allow the app to read user profile."
        admin_consent_display_name = "Read user profile"
        enabled                    = true
        id                         = "33333333-3333-3333-3333-333333333333"
        type                       = "User"
        user_consent_description   = "Allow this app to read your profile."
        user_consent_display_name  = "Read your profile"
        value                      = "User.Read"
      }
    ]
  }
}


provider "azuread" {}

module "azuread_app" {
  source = "./modules/azuread_app"

  display_name                   = var.display_name
  description                    = var.description
  device_only_auth_enabled       = var.device_only_auth_enabled
  fallback_public_client_enabled = var.fallback_public_client_enabled
  feature_tags                   = var.feature_tags
  group_membership_claims        = var.group_membership_claims
  identifier_uris                = var.identifier_uris
  logo_image                     = var.logo_image
  marketing_url                  = var.marketing_url
  notes                          = var.notes
  oauth2_post_response_required  = var.oauth2_post_response_required
  optional_claims                = var.optional_claims
  owners                         = var.owners
  password                       = var.password
  prevent_duplicate_names        = var.prevent_duplicate_names
  privacy_statement_url          = var.privacy_statement_url
  public_client                  = var.public_client
  required_resource_access       = var.required_resource_access
  service_management_reference   = var.service_management_reference
  sign_in_audience               = var.sign_in_audience
  single_page_application        = var.single_page_application
  support_url                    = var.support_url
  tags                           = var.tags
  template_id                    = var.template_id
  terms_of_service_url           = var.terms_of_service_url
  web                            = var.web
  app_role                       = var.app_role
  api                            = var.api
}
