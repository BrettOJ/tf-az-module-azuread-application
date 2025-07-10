# tf-az-module-azuread-application
Terraform module to create an Entra ID application 
---
created: 2025-07-10T11:59:50 (UTC +08:00)
tags: []
source: https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application
author: 
---

# azuread_application | Resources | hashicorp/azuread | Terraform | Terraform Registry

> ## Excerpt
> Manages an application registration within Azure Active Directory.

---
## Resource: azuread\_application

Manages an application registration within Azure Active Directory.

For a more lightweight alternative, please see the [azuread\_application\_registration](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_registration) resource. Please note that this resource should not be used together with the `azuread_application_registration` resource when managing the same application.

## [API Permissions](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#api-permissions)

The following API permissions are required in order to use this resource.

When authenticated with a service principal, this resource requires one of the following application roles: `Application.ReadWrite.OwnedBy` or `Application.ReadWrite.All`

Additionally, you may need the `User.Read.All` application role when including user principals in the `owners` property.

When authenticated with a user principal, this resource may require one of the following directory roles: `Application Administrator` or `Global Administrator`

## [Example Usage](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#example-usage)

_Create an application_

```terraform
data "azuread_client_config" "current" {} resource "azuread_application" "example" { display_name = "example" identifier_uris = ["api://example-app"] logo_image = filebase64("/path/to/logo.png") owners = [data.azuread_client_config.current.object_id] sign_in_audience = "AzureADMultipleOrgs" api { mapped_claims_enabled = true requested_access_token_version = 2 known_client_applications = [ azuread_application.known1.client_id, azuread_application.known2.client_id, ] oauth2_permission_scope { admin_consent_description = "Allow the application to access example on behalf of the signed-in user." admin_consent_display_name = "Access example" enabled = true id = "96183846-204b-4b43-82e1-5d2222eb4b9b" type = "User" user_consent_description = "Allow the application to access example on your behalf." user_consent_display_name = "Access example" value = "user_impersonation" } oauth2_permission_scope { admin_consent_description = "Administer the example application" admin_consent_display_name = "Administer" enabled = true id = "be98fa3e-ab5b-4b11-83d9-04ba2b7946bc" type = "Admin" value = "administer" } } app_role { allowed_member_types = ["User", "Application"] description = "Admins can manage roles and perform all task actions" display_name = "Admin" enabled = true id = "1b19509b-32b1-4e9f-b71d-4992aa991967" value = "admin" } app_role { allowed_member_types = ["User"] description = "ReadOnly roles have limited query access" display_name = "ReadOnly" enabled = true id = "497406e4-012a-4267-bf18-45a1cb148a01" value = "User" } feature_tags { enterprise = true gallery = true } optional_claims { access_token { name = "myclaim" } access_token { name = "otherclaim" } id_token { name = "userclaim" source = "user" essential = true additional_properties = ["emit_as_roles"] } saml2_token { name = "samlexample" } } required_resource_access { resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph resource_access { id = "df021288-bdef-4463-88db-98f22de89214" # User.Read.All type = "Role" } resource_access { id = "b4e74841-8e56-480b-be8b-910348b18b4c" # User.ReadWrite type = "Scope" } } required_resource_access { resource_app_id = "c5393580-f805-4401-95e8-94b7a6ef2fc2" # Office 365 Management resource_access { id = "594c1fb6-4f81-4475-ae41-0c394909246c" # ActivityFeed.Read type = "Role" } } web { homepage_url = "https://app.example.net" logout_url = "https://app.example.net/logout" redirect_uris = ["https://app.example.net/account"] implicit_grant { access_token_issuance_enabled = true id_token_issuance_enabled = true } } }
```

_Create application and generate a password_

```terraform
data "azuread_client_config" "current" {} resource "time_rotating" "example" { rotation_days = 180 } resource "azuread_application" "example" { display_name = "example" owners = [data.azuread_client_config.current.object_id] password { display_name = "MySecret-1" start_date = time_rotating.example.id end_date = timeadd(time_rotating.example.id, "4320h") } } output "example_password" { sensitive = true value = tolist(azuread_application.example.password).0.value }
```

_Create application from a gallery template_

```terraform
data "azuread_application_template" "example" { display_name = "Marketo" } resource "azuread_application" "example" { display_name = "example" template_id = data.azuread_application_template.example.template_id } resource "azuread_service_principal" "example" { client_id = azuread_application.example.client_id use_existing = true }
```

## [Argument Reference](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#argument-reference)

The following arguments are supported:

-   [`api`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#api-1) - (Optional) An `api` block as documented below, which configures API related settings for this application.
-   [`app_role`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#app_role-1) - (Optional) A collection of `app_role` blocks as documented below. For more information see [official documentation on Application Roles](https://docs.microsoft.com/en-us/azure/architecture/multitenant-identity/app-roles).
-   [`description`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#description-1) - (Optional) A description of the application, as shown to end users.
-   [`device_only_auth_enabled`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#device_only_auth_enabled-1) - (Optional) Specifies whether this application supports device authentication without a user. Defaults to `false`.
-   [`display_name`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#display_name-1) - (Required) The display name for the application.
-   [`fallback_public_client_enabled`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#fallback_public_client_enabled-1) - (Optional) Specifies whether the application is a public client. Appropriate for apps using token grant flows that don't use a redirect URI. Defaults to `false`.
-   [`feature_tags`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#feature_tags-1) - (Optional) A `feature_tags` block as described below. Cannot be used together with the `tags` property.

-   [`group_membership_claims`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#group_membership_claims-1) - (Optional) A set of strings containing membership claims issued in a user or OAuth 2.0 access token that the app expects. Possible values are `None`, `SecurityGroup`, `DirectoryRole`, `ApplicationGroup` or `All`.
-   [`identifier_uris`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#identifier_uris-1) - (Optional) A set of user-defined URI(s) that uniquely identify an application within its Azure AD tenant, or within a verified custom domain if the application is multi-tenant.
-   [`logo_image`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#logo_image-1) - (Optional) A logo image to upload for the application, as a raw base64-encoded string. The image should be in gif, jpeg or png format. Note that once an image has been uploaded, it is not possible to remove it without replacing it with another image.
-   [`marketing_url`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#marketing_url-1) - (Optional) URL of the application's marketing page.
-   [`notes`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#notes-1) - (Optional) User-specified notes relevant for the management of the application.
-   [`oauth2_post_response_required`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#oauth2_post_response_required-1) - (Optional) Specifies whether, as part of OAuth 2.0 token requests, Azure AD allows POST requests, as opposed to GET requests. Defaults to `false`, which specifies that only GET requests are allowed.
-   [`optional_claims`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#optional_claims-1) - (Optional) An `optional_claims` block as documented below.
-   [`owners`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#owners-1) - (Optional) A set of object IDs of principals that will be granted ownership of the application. Supported object types are users or service principals. By default, no owners are assigned.

-   [`password`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#password-1) - (Optional) A single `password` block as documented below. The password is generated during creation. By default, no password is generated.

-   [`prevent_duplicate_names`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#prevent_duplicate_names-1) - (Optional) If `true`, will return an error if an existing application is found with the same name. Defaults to `false`.
-   [`privacy_statement_url`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#privacy_statement_url-1) - (Optional) URL of the application's privacy statement.
-   [`public_client`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#public_client-1) - (Optional) A `public_client` block as documented below, which configures non-web app or non-web API application settings, for example mobile or other public clients such as an installed application running on a desktop device.
-   [`required_resource_access`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#required_resource_access-1) - (Optional) A collection of `required_resource_access` blocks as documented below.
-   [`service_management_reference`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#service_management_reference-1) - (Optional) References application context information from a Service or Asset Management database.
-   [`sign_in_audience`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#sign_in_audience-1) - (Optional) The Microsoft account types that are supported for the current application. Must be one of `AzureADMyOrg`, `AzureADMultipleOrgs`, `AzureADandPersonalMicrosoftAccount` or `PersonalMicrosoftAccount`. Defaults to `AzureADMyOrg`.

-   [`single_page_application`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#single_page_application-1) - (Optional) A `single_page_application` block as documented below, which configures single-page application (SPA) related settings for this application.
-   [`support_url`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#support_url-1) - (Optional) URL of the application's support page.
-   [`tags`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#tags-1) - (Optional) A set of tags to apply to the application for configuring specific behaviours of the application and linked service principals. Note that these are not provided for use by practitioners. Cannot be used together with the `feature_tags` block.

-   [`template_id`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#template_id-1) - (Optional) Unique ID for a templated application in the Azure AD App Gallery, from which to create the application. Changing this forces a new resource to be created.

-   [`terms_of_service_url`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#terms_of_service_url-1) - (Optional) URL of the application's terms of service statement.
-   [`web`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#web-1) - (Optional) A `web` block as documented below, which configures web related settings for this application.

___

`api` block supports the following:

-   [`known_client_applications`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#known_client_applications-1) - (Optional) A set of client IDs, used for bundling consent if you have a solution that contains two parts: a client app and a custom web API app.
-   [`mapped_claims_enabled`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#mapped_claims_enabled-1) - (Optional) Allows an application to use claims mapping without specifying a custom signing key. Defaults to `false`.
-   [`oauth2_permission_scope`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#oauth2_permission_scope-1) - (Optional) One or more `oauth2_permission_scope` blocks as documented below, to describe delegated permissions exposed by the web API represented by this application.
-   [`requested_access_token_version`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#requested_access_token_version-1) - (Optional) The access token version expected by this resource. Must be one of `1` or `2`, and must be `2` when `sign_in_audience` is either `AzureADandPersonalMicrosoftAccount` or `PersonalMicrosoftAccount` Defaults to `1`.

___

`oauth2_permission_scope` blocks support the following:

-   [`admin_consent_description`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#admin_consent_description-1) - (Required) Delegated permission description that appears in all tenant-wide admin consent experiences, intended to be read by an administrator granting the permission on behalf of all users.
-   [`admin_consent_display_name`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#admin_consent_display_name-1) - (Required) Display name for the delegated permission, intended to be read by an administrator granting the permission on behalf of all users.
-   [`enabled`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#enabled-1) - (Optional) Determines if the permission scope is enabled. Defaults to `true`.
-   [`id`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#id-1) - (Required) The unique identifier of the delegated permission. Must be a valid UUID.

-   [`type`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#type-1) - (Optional) Whether this delegated permission should be considered safe for non-admin users to consent to on behalf of themselves, or whether an administrator should be required for consent to the permissions. Defaults to `User`. Possible values are `User` or `Admin`.
-   [`user_consent_description`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#user_consent_description-1) - (Optional) Delegated permission description that appears in the end user consent experience, intended to be read by a user consenting on their own behalf.
-   [`user_consent_display_name`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#user_consent_display_name-1) - (Optional) Display name for the delegated permission that appears in the end user consent experience.
-   [`value`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#value-1) - (Optional) The value that is used for the `scp` claim in OAuth 2.0 access tokens.

___

`app_role` block supports the following:

-   [`allowed_member_types`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#allowed_member_types-1) - (Required) Specifies whether this app role definition can be assigned to users and groups by setting to `User`, or to other applications (that are accessing this application in a standalone scenario) by setting to `Application`, or to both.
-   [`description`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#description-2) - (Required) Description of the app role that appears when the role is being assigned and, if the role functions as an application permissions, during the consent experiences.
-   [`display_name`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#display_name-2) - (Required) Display name for the app role that appears during app role assignment and in consent experiences.
-   [`enabled`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#enabled-2) - (Optional) Determines if the app role is enabled. Defaults to `true`.
-   [`id`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#id-2) - (Required) The unique identifier of the app role. Must be a valid UUID.

-   [`value`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#value-2) - (Optional) The value that is used for the `roles` claim in ID tokens and OAuth 2.0 access tokens that are authenticating an assigned service or user principal.

___

`feature_tags` block supports the following:

-   [`custom_single_sign_on`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#custom_single_sign_on-1) - (Optional) Whether this application represents a custom SAML application for linked service principals. Enabling this will assign the `WindowsAzureActiveDirectoryCustomSingleSignOnApplication` tag. Defaults to `false`.
-   [`enterprise`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#enterprise-1) - (Optional) Whether this application represents an Enterprise Application for linked service principals. Enabling this will assign the `WindowsAzureActiveDirectoryIntegratedApp` tag. Defaults to `false`.
-   [`gallery`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#gallery-1) - (Optional) Whether this application represents a gallery application for linked service principals. Enabling this will assign the `WindowsAzureActiveDirectoryGalleryApplicationNonPrimaryV1` tag. Defaults to `false`.
-   [`hide`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#hide-1) - (Optional) Whether this app is invisible to users in My Apps and Office 365 Launcher. Enabling this will assign the `HideApp` tag. Defaults to `false`.

___

`optional_claims` block supports the following:

-   [`access_token`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#access_token-1) - (Optional) One or more `access_token` blocks as documented below.
-   [`id_token`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#id_token-1) - (Optional) One or more `id_token` blocks as documented below.
-   [`saml2_token`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#saml2_token-1) - (Optional) One or more `saml2_token` blocks as documented below.

___

`access_token`, `id_token` and `saml2_token` blocks support the following:

-   [`additional_properties`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#additional_properties-1) - List of additional properties of the claim. If a property exists in this list, it modifies the behaviour of the optional claim. Possible values are: `cloud_displayname`, `dns_domain_and_sam_account_name`, `emit_as_roles`, `include_externally_authenticated_upn_without_hash`, `include_externally_authenticated_upn`, `max_size_limit`, `netbios_domain_and_sam_account_name`, `on_premise_security_identifier`, `sam_account_name`, and `use_guid`.
-   [`essential`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#essential-1) - Whether the claim specified by the client is necessary to ensure a smooth authorization experience.
-   [`name`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#name-1) - The name of the optional claim.
-   [`source`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#source-1) - The source of the claim. If `source` is absent, the claim is a predefined optional claim. If `source` is `user`, the value of `name` is the extension property from the user object.

___

`password` block supports the following:

-   [`display_name`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#display_name-3) - (Required) A display name for the password. Changing this field forces a new resource to be created.
-   [`end_date`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#end_date-1) - (Optional) The end date until which the password is valid, formatted as an RFC3339 date string (e.g. `2018-01-01T01:02:03Z`). Changing this field forces a new resource to be created.
-   [`start_date`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#start_date-1) - (Optional) The start date from which the password is valid, formatted as an RFC3339 date string (e.g. `2018-01-01T01:02:03Z`). If this isn't specified, the current date is used. Changing this field forces a new resource to be created.

___

`public_client` block supports the following:

-   [`redirect_uris`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#redirect_uris-1) - (Optional) A set of URLs where user tokens are sent for sign-in, or the redirect URIs where OAuth 2.0 authorization codes and access tokens are sent. Must be a valid `https` or `ms-appx-web` URL.

___

`required_resource_access` block supports the following:

-   [`resource_access`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#resource_access-1) - (Required) A collection of `resource_access` blocks as documented below, describing OAuth2.0 permission scopes and app roles that the application requires from the specified resource.
-   [`resource_app_id`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#resource_app_id-1) - (Required) The unique identifier for the resource that the application requires access to. This should be the Application ID of the target application.

___

`resource_access` block supports the following:

-   [`id`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#id-3) - (Required) The unique identifier for an app role or OAuth2 permission scope published by the resource application.
-   [`type`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#type-2) - (Required) Specifies whether the `id` property references an app role or an OAuth2 permission scope. Possible values are `Role` or `Scope`.

___

`single_page_application` block supports the following:

-   [`redirect_uris`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#redirect_uris-2) - (Optional) A set of URLs where user tokens are sent for sign-in, or the redirect URIs where OAuth 2.0 authorization codes and access tokens are sent. Must be a valid `https` URL.

___

`web` block supports the following:

-   [`homepage_url`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#homepage_url-1) - (Optional) Home page or landing page of the application.
-   [`implicit_grant`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#implicit_grant-1) - (Optional) An `implicit_grant` block as documented above.
-   [`logout_url`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#logout_url-1) - (Optional) The URL that will be used by Microsoft's authorization service to sign out a user using front-channel, back-channel or SAML logout protocols.
-   [`redirect_uris`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#redirect_uris-3) - (Optional) A set of URLs where user tokens are sent for sign-in, or the redirect URIs where OAuth 2.0 authorization codes and access tokens are sent. Must be a valid `http` URL or a URN.

___

`implicit_grant` block supports the following:

-   [`access_token_issuance_enabled`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#access_token_issuance_enabled-1) - (Optional) Whether this web application can request an access token using OAuth 2.0 implicit flow.
-   [`id_token_issuance_enabled`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#id_token_issuance_enabled-1) - (Optional) Whether this web application can request an ID token using OAuth 2.0 implicit flow.

___

## [Attributes Reference](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#attributes-reference)

In addition to all arguments above, the following attributes are exported:

-   [`app_role_ids`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#app_role_ids-1) - A mapping of app role values to app role IDs, intended to be useful when referencing app roles in other resources in your configuration.
-   [`client_id`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#client_id-2) - The Client ID for the application.
-   [`disabled_by_microsoft`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#disabled_by_microsoft-1) - Whether Microsoft has disabled the registered application. If the application is disabled, this will be a string indicating the status/reason, e.g. `DisabledDueToViolationOfServicesAgreement`
-   [`id`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#id-4) - The Terraform resource ID for the application, for use when referencing this resource in your Terraform configuration.
-   [`logo_url`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#logo_url-1) - CDN URL to the application's logo, as uploaded with the `logo_image` property.
-   [`oauth2_permission_scope_ids`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#oauth2_permission_scope_ids-1) - A mapping of OAuth2.0 permission scope values to scope IDs, intended to be useful when referencing permission scopes in other resources in your configuration.
-   [`object_id`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#object_id-1) - The application's object ID.
-   [`password`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#password-2) - A `password` block as documented below. Note that this block is a set rather than a list, and you will need to convert or iterate it to address its attributes (see the usage example above).
-   [`publisher_domain`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#publisher_domain-1) - The verified publisher domain for the application.

___

`password` block exports the following:

-   [`key_id`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#key_id-1) - (Required) The unique key ID for the generated password.
-   [`value`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#value-3) - (Required) The generated password for the application.

## [Timeouts](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#timeouts)

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

-   [`create`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#create-1) - (Defaults to 10 minutes) Used when creating the resource.
-   [`read`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#read-1) - (Defaults to 5 minutes) Used when retrieving the resource.
-   [`update`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#update-1) - (Defaults to 10 minutes) Used when updating the resource.
-   [`delete`](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#delete-1) - (Defaults to 5 minutes) Used when deleting the resource.

## [Import](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application#import)

Applications can be imported using the object ID of the application, in the following format.

```shell
terraform import azuread_application.example /applications/00000000-0000-0000-0000-000000000000
```
