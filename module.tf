resource "azuread_application" "app_registration" {
  display_name                   = var.display_name
  description                    = var.description
  device_only_auth_enabled       = var.device_only_auth_enabled
  fallback_public_client_enabled = var.fallback_public_client_enabled
  group_membership_claims        = var.group_membership_claims
  identifier_uris                = var.identifier_uris
  logo_image                     = var.logo_image
  marketing_url                  = var.marketing_url
  notes                          = var.notes
  oauth2_post_response_required  = var.oauth2_post_response_required
  owners                         = var.owners
  prevent_duplicate_names        = var.prevent_duplicate_names
  privacy_statement_url          = var.privacy_statement_url
  service_management_reference   = var.service_management_reference
  sign_in_audience               = var.sign_in_audience
  support_url                    = var.support_url
  tags                           = var.tags
  template_id                    = var.template_id
  terms_of_service_url           = var.terms_of_service_url

  dynamic "feature_tags" {
    for_each = var.feature_tags != null ? [var.feature_tags] : []
    content {
      custom_single_sign_on = lookup(feature_tags.value, "custom_single_sign_on", null)
      enterprise             = lookup(feature_tags.value, "enterprise", null)
      gallery                = lookup(feature_tags.value, "gallery", null)
      hide                   = lookup(feature_tags.value, "hide", null)
    }
  }

  dynamic "password" {
    for_each = var.password != null ? [var.password] : []
    content {
      display_name = password.value.display_name
      end_date     = lookup(password.value, "end_date", null)
      start_date   = lookup(password.value, "start_date", null)
    }
  }

  dynamic "public_client" {
    for_each = var.public_client != null ? [var.public_client] : []
    content {
      redirect_uris = public_client.value.redirect_uris
    }
  }

  dynamic "single_page_application" {
    for_each = var.single_page_application != null ? [var.single_page_application] : []
    content {
      redirect_uris = single_page_application.value.redirect_uris
    }
  }

  dynamic "web" {
    for_each = var.web != null ? [var.web] : []
    content {
      homepage_url  = lookup(web.value, "homepage_url", null)
      logout_url    = lookup(web.value, "logout_url", null)
      redirect_uris = lookup(web.value, "redirect_uris", null)

      dynamic "implicit_grant" {
        for_each = contains(keys(web.value), "implicit_grant") ? [web.value.implicit_grant] : []
        content {
          access_token_issuance_enabled = lookup(implicit_grant.value, "access_token_issuance_enabled", null)
          id_token_issuance_enabled     = lookup(implicit_grant.value, "id_token_issuance_enabled", null)
        }
      }
    }
  }

  dynamic "optional_claims" {
    for_each = var.optional_claims != null ? [var.optional_claims] : []
    content {
      dynamic "access_token" {
        for_each = lookup(optional_claims.value, "access_token", [])
        content {
          name                  = access_token.value.name
          source                = lookup(access_token.value, "source", null)
          essential             = lookup(access_token.value, "essential", null)
          additional_properties = lookup(access_token.value, "additional_properties", null)
        }
      }

      dynamic "id_token" {
        for_each = lookup(optional_claims.value, "id_token", [])
        content {
          name                  = id_token.value.name
          source                = lookup(id_token.value, "source", null)
          essential             = lookup(id_token.value, "essential", null)
          additional_properties = lookup(id_token.value, "additional_properties", null)
        }
      }

      dynamic "saml2_token" {
        for_each = lookup(optional_claims.value, "saml2_token", [])
        content {
          name                  = saml2_token.value.name
          source                = lookup(saml2_token.value, "source", null)
          essential             = lookup(saml2_token.value, "essential", null)
          additional_properties = lookup(saml2_token.value, "additional_properties", null)
        }
      }
    }
  }

  dynamic "app_role" {
    for_each = var.app_role
    content {
      allowed_member_types = app_role.value.allowed_member_types
      description           = app_role.value.description
      display_name          = app_role.value.display_name
      enabled               = lookup(app_role.value, "enabled", true)
      id                    = app_role.value.id
      value                 = lookup(app_role.value, "value", null)
    }
  }

  dynamic "required_resource_access" {
    for_each = var.required_resource_access
    content {
      resource_app_id = required_resource_access.value.resource_app_id

      dynamic "resource_access" {
        for_each = required_resource_access.value.resource_access
        content {
          id   = resource_access.value.id
          type = resource_access.value.type
        }
      }
    }
  }

  dynamic "api" {
    for_each = var.api != null ? [var.api] : []
    content {
      known_client_applications     = lookup(api.value, "known_client_applications", null)
      mapped_claims_enabled         = lookup(api.value, "mapped_claims_enabled", null)
      requested_access_token_version = lookup(api.value, "requested_access_token_version", null)

      dynamic "oauth2_permission_scope" {
        for_each = lookup(api.value, "oauth2_permission_scope", [])
        content {
          admin_consent_description  = oauth2_permission_scope.value.admin_consent_description
          admin_consent_display_name = oauth2_permission_scope.value.admin_consent_display_name
          enabled                    = lookup(oauth2_permission_scope.value, "enabled", true)
          id                         = oauth2_permission_scope.value.id
          type                       = lookup(oauth2_permission_scope.value, "type", null)
          user_consent_description   = lookup(oauth2_permission_scope.value, "user_consent_description", null)
          user_consent_display_name  = lookup(oauth2_permission_scope.value, "user_consent_display_name", null)
          value                      = lookup(oauth2_permission_scope.value, "value", null)
        }
      }
    }
  }
}
