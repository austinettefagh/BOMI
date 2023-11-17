{
    "size": 1,
    "totalSize": 1,
    "done": true,
    "queryLocator": null,
    "entityTypeName": "SecurityHealthCheck",
    "records": [
        {
            "attributes": {
                "type": "SecurityHealthCheck",
                "url": "/services/data/v48.0/tooling/sobjects/SecurityHealthCheck/0"
            },
            "Score": "76",
            "CustomBaselineId": "0",
            "SecurityHealthCheckRisk": {
                "size": 37,
                "totalSize": 37,
                "done": true,
                "queryLocator": null,
                "entityTypeName": "SecurityHealthCheckRisks",
                "records": [
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "HIGH_RISK",
                        "Setting": "Enable clickjack protection for customer Visualforce pages with standard headers",
                        "SettingGroup": "SessionSettings",
                        "OrgValue": "Disabled",
                        "StandardValue": "Enabled",
                        "OrgValueRaw": "false",
                        "StandardValueRaw": "true",
                        "SettingRiskCategory": "HIGH_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "HIGH_RISK",
                        "Setting": "Enable clickjack protection for customer Visualforce pages with headers disabled",
                        "SettingGroup": "SessionSettings",
                        "OrgValue": "Disabled",
                        "StandardValue": "Enabled",
                        "OrgValueRaw": "false",
                        "StandardValueRaw": "true",
                        "SettingRiskCategory": "HIGH_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "HIGH_RISK",
                        "Setting": "Require HttpOnly attribute",
                        "SettingGroup": "SessionSettings",
                        "OrgValue": "Disabled",
                        "StandardValue": "Enabled",
                        "OrgValueRaw": "false",
                        "StandardValueRaw": "true",
                        "SettingRiskCategory": "HIGH_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEDIUM_RISK",
                        "Setting": "Maximum invalid login attempts",
                        "SettingGroup": "PasswordPolicies",
                        "OrgValue": "10",
                        "StandardValue": "3",
                        "OrgValueRaw": "TenAttempts",
                        "StandardValueRaw": "ThreeAttempts",
                        "SettingRiskCategory": "HIGH_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Expired Certificate",
                        "SettingGroup": "CertificateAndKeyManagement",
                        "OrgValue": "0",
                        "StandardValue": "0",
                        "OrgValueRaw": "0",
                        "StandardValueRaw": "0",
                        "SettingRiskCategory": "HIGH_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Number of security risk file types with Hybrid behavior",
                        "SettingGroup": "FileUploadAndDownloadSecurity",
                        "OrgValue": "0 security risk file types with Hybrid behavior",
                        "StandardValue": "0 security risk file types with Hybrid behavior",
                        "OrgValueRaw": "0",
                        "StandardValueRaw": "0",
                        "SettingRiskCategory": "HIGH_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Lock sessions to the domain in which they were first used",
                        "SettingGroup": "SessionSettings",
                        "OrgValue": "Enabled",
                        "StandardValue": "Enabled",
                        "OrgValueRaw": "true",
                        "StandardValueRaw": "true",
                        "SettingRiskCategory": "HIGH_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Let users verify their identity by text (SMS)",
                        "SettingGroup": "SessionSettings",
                        "OrgValue": "Enabled",
                        "StandardValue": "Enabled",
                        "OrgValueRaw": "true",
                        "StandardValueRaw": "true",
                        "SettingRiskCategory": "HIGH_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Enable clickjack protection for Setup pages",
                        "SettingGroup": "SessionSettings",
                        "OrgValue": "Enabled",
                        "StandardValue": "Enabled",
                        "OrgValueRaw": "true",
                        "StandardValueRaw": "true",
                        "SettingRiskCategory": "HIGH_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Enable clickjack protection for non-Setup Salesforce pages",
                        "SettingGroup": "SessionSettings",
                        "OrgValue": "Enabled",
                        "StandardValue": "Enabled",
                        "OrgValueRaw": "true",
                        "StandardValueRaw": "true",
                        "SettingRiskCategory": "HIGH_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Enable CSRF protection on GET requests on non-setup pages",
                        "SettingGroup": "SessionSettings",
                        "OrgValue": "Enabled",
                        "StandardValue": "Enabled",
                        "OrgValueRaw": "true",
                        "StandardValueRaw": "true",
                        "SettingRiskCategory": "HIGH_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Enable CSRF protection on POST requests on non-setup pages",
                        "SettingGroup": "SessionSettings",
                        "OrgValue": "Enabled",
                        "StandardValue": "Enabled",
                        "OrgValueRaw": "true",
                        "StandardValueRaw": "true",
                        "SettingRiskCategory": "HIGH_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Require secure connections (HTTPS)",
                        "SettingGroup": "SessionSettings",
                        "OrgValue": "Enabled",
                        "StandardValue": "Enabled",
                        "OrgValueRaw": "true",
                        "StandardValueRaw": "true",
                        "SettingRiskCategory": "HIGH_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Require secure connections (HTTPS) for all third-party domains",
                        "SettingGroup": "SessionSettings",
                        "OrgValue": "Enabled",
                        "StandardValue": "Enabled",
                        "OrgValueRaw": "true",
                        "StandardValueRaw": "true",
                        "SettingRiskCategory": "HIGH_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Number of Objects with Default External Access Set to Public",
                        "SettingGroup": "SharingSettings",
                        "OrgValue": "0",
                        "StandardValue": "0",
                        "OrgValueRaw": "0",
                        "StandardValueRaw": "0",
                        "SettingRiskCategory": "HIGH_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "HIGH_RISK",
                        "Setting": "Require a minimum 1 day password lifetime",
                        "SettingGroup": "PasswordPolicies",
                        "OrgValue": "Disabled",
                        "StandardValue": "Enabled",
                        "OrgValueRaw": "false",
                        "StandardValueRaw": "true",
                        "SettingRiskCategory": "MEDIUM_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "HIGH_RISK",
                        "Setting": "Enforce login IP ranges on every request",
                        "SettingGroup": "SessionSettings",
                        "OrgValue": "Disabled",
                        "StandardValue": "Enabled",
                        "OrgValueRaw": "false",
                        "StandardValueRaw": "true",
                        "SettingRiskCategory": "MEDIUM_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEDIUM_RISK",
                        "Setting": "Password complexity requirement",
                        "SettingGroup": "PasswordPolicies",
                        "OrgValue": "Must include alpha and numeric characters",
                        "StandardValue": "Must include alpha, numeric, and special characters",
                        "OrgValueRaw": "AlphaNumeric",
                        "StandardValueRaw": "SpecialCharacters",
                        "SettingRiskCategory": "MEDIUM_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "User passwords expire in",
                        "SettingGroup": "PasswordPolicies",
                        "OrgValue": "90 days",
                        "StandardValue": "30 days",
                        "OrgValueRaw": "NinetyDays",
                        "StandardValueRaw": "ThirtyDays",
                        "SettingRiskCategory": "MEDIUM_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Enforce password history",
                        "SettingGroup": "PasswordPolicies",
                        "OrgValue": "3 passwords remembered",
                        "StandardValue": "3 passwords remembered",
                        "OrgValueRaw": "3",
                        "StandardValueRaw": "3",
                        "SettingRiskCategory": "MEDIUM_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Minimum password length",
                        "SettingGroup": "PasswordPolicies",
                        "OrgValue": "8 characters",
                        "StandardValue": "8 characters",
                        "OrgValueRaw": "8",
                        "StandardValueRaw": "8",
                        "SettingRiskCategory": "MEDIUM_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Force relogin after Login-As-User",
                        "SettingGroup": "SessionSettings",
                        "OrgValue": "Enabled",
                        "StandardValue": "Enabled",
                        "OrgValueRaw": "true",
                        "StandardValueRaw": "true",
                        "SettingRiskCategory": "MEDIUM_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Enable Content Security Policy protection for email templates",
                        "SettingGroup": "SessionSettings",
                        "OrgValue": "Enabled",
                        "StandardValue": "Enabled",
                        "OrgValueRaw": "true",
                        "StandardValueRaw": "true",
                        "SettingRiskCategory": "MEDIUM_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Enable XSS protection",
                        "SettingGroup": "SessionSettings",
                        "OrgValue": "Enabled",
                        "StandardValue": "Enabled",
                        "OrgValueRaw": "true",
                        "StandardValueRaw": "true",
                        "SettingRiskCategory": "MEDIUM_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Enable Content Sniffing protection",
                        "SettingGroup": "SessionSettings",
                        "OrgValue": "Enabled",
                        "StandardValue": "Enabled",
                        "OrgValueRaw": "true",
                        "StandardValueRaw": "true",
                        "SettingRiskCategory": "MEDIUM_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Administrators Can Log in as Any User",
                        "SettingGroup": "LoginAccessPolicies",
                        "OrgValue": "Disabled",
                        "StandardValue": "Disabled",
                        "OrgValueRaw": "false",
                        "StandardValueRaw": "false",
                        "SettingRiskCategory": "MEDIUM_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "HIGH_RISK",
                        "Setting": "Obscure secret answer for password resets",
                        "SettingGroup": "PasswordPolicies",
                        "OrgValue": "Disabled",
                        "StandardValue": "Enabled",
                        "OrgValueRaw": "false",
                        "StandardValueRaw": "true",
                        "SettingRiskCategory": "LOW_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "HIGH_RISK",
                        "Setting": "Require identity verification for email address changes",
                        "SettingGroup": "SessionSettings",
                        "OrgValue": "Disabled",
                        "StandardValue": "Enabled",
                        "OrgValueRaw": "false",
                        "StandardValueRaw": "true",
                        "SettingRiskCategory": "LOW_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEDIUM_RISK",
                        "Setting": "Lockout effective period",
                        "SettingGroup": "PasswordPolicies",
                        "OrgValue": "15 minutes",
                        "StandardValue": "30 minutes",
                        "OrgValueRaw": "FifteenMinutes",
                        "StandardValueRaw": "ThirtyMinutes",
                        "SettingRiskCategory": "LOW_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Remote Site Settings",
                        "SettingGroup": "RemoteSiteSettings",
                        "OrgValue": "No remote sites with the Disable Protocol Security option selected",
                        "StandardValue": "No remote sites with the Disable Protocol Security option selected",
                        "OrgValueRaw": "No remote sites with the Disable Protocol Security option selected",
                        "StandardValueRaw": "No remote sites with the Disable Protocol Security option selected",
                        "SettingRiskCategory": "LOW_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Password question requirement",
                        "SettingGroup": "PasswordPolicies",
                        "OrgValue": "Cannot contain password",
                        "StandardValue": "Cannot contain password",
                        "OrgValueRaw": "DoesNotContainPassword",
                        "StandardValueRaw": "DoesNotContainPassword",
                        "SettingRiskCategory": "LOW_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Force logout on session timeout",
                        "SettingGroup": "SessionSettings",
                        "OrgValue": "Enabled",
                        "StandardValue": "Enabled",
                        "OrgValueRaw": "true",
                        "StandardValueRaw": "true",
                        "SettingRiskCategory": "LOW_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Require identity verification during two-factor authentication (2FA) registration",
                        "SettingGroup": "SessionSettings",
                        "OrgValue": "Enabled",
                        "StandardValue": "Enabled",
                        "OrgValueRaw": "true",
                        "StandardValueRaw": "true",
                        "SettingRiskCategory": "LOW_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Session Timeout",
                        "SettingGroup": "SessionSettings",
                        "OrgValue": "2 hours",
                        "StandardValue": "15 minutes",
                        "OrgValueRaw": "TwoHours",
                        "StandardValueRaw": "FifteenMinutes",
                        "SettingRiskCategory": "LOW_RISK"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Key Size",
                        "SettingGroup": "CertificateAndKeyManagement",
                        "OrgValue": "No certificate created",
                        "StandardValue": "4096",
                        "OrgValueRaw": "No certificate created",
                        "StandardValueRaw": "4096",
                        "SettingRiskCategory": "INFORMATIONAL"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Certificate Expiration",
                        "SettingGroup": "CertificateAndKeyManagement",
                        "OrgValue": "No certificate created",
                        "StandardValue": "179 days",
                        "OrgValueRaw": "9223372036854775807",
                        "StandardValueRaw": "179",
                        "SettingRiskCategory": "INFORMATIONAL"
                    },
                    {
                        "attributes": {
                            "type": "SecurityHealthCheckRisks"
                        },
                        "RiskType": "MEETS_STANDARD",
                        "Setting": "Enable HSTS for all Sites and Communities with the default force.com subdomain that require a secure connection (HTTPS)",
                        "SettingGroup": "SessionSettings",
                        "OrgValue": "Enabled",
                        "StandardValue": "Enabled",
                        "OrgValueRaw": "true",
                        "StandardValueRaw": "true",
                        "SettingRiskCategory": "INFORMATIONAL"
                    }
                ]
            }
        }
    ]
}