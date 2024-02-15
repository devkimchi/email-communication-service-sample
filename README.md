# Azure Email Communication Service Sample

This provides sample codes to provision [Azure Email Communication Services (ECS)](https://learn.microsoft.com/azure/communication-services/quickstarts/email/create-email-communication-resource) resource and apps using it to send emails.

## Prerequisites

- [.NET SDK 8](https://dotnet.microsoft.com/download/dotnet/8.0) or later
- [Visual Studio Code](https://code.visualstudio.com/)
- [Azure Developer CLI](https://learn.microsoft.com/azure/developer/azure-developer-cli/overview)
- [Azure CLI](https://learn.microsoft.com/cli/azure/what-is-azure-cli) with the [Communication extension](https://github.com/Azure/azure-cli-extensions/tree/main/src/communication)
- A custom domain name to use with the [Azure Email Communication Services (ECS)](https://learn.microsoft.com/azure/communication-services/quickstarts/email/create-email-communication-resource) resource

## Getting Started

### Provision resources to Azure

1. Fork this repository to your GitHub account.
1. Run the commands below to set up a resource names:

    ```bash
    # Bash
    AZURE_ENV_NAME="notifications$RANDOM"
 
    # PowerShell
    $AZURE_ENV_NAME="notifications$(Get-Random -Min 1000 -Max 9999)"
    ```

1. Run the commands below to provision Azure resources:

    ```bash
    azd auth login
    azd init -e $AZURE_ENV_NAME
    azd up
    ```

   > **Note:** You may be asked to enter your Azure subscription, desired location and data location, custom domain name, and custom email address to provision resources. If you don't provide the custom domain name, only Azure managed domain will be provisioned.

1. Verify the custom domain by following this document: [Verify custom domain for ECS](https://learn.microsoft.com/azure/communication-services/quickstarts/email/add-custom-verified-domains)
1. Connect the custom domain to ACS by following this document: [Connect custom domain to ACS](https://learn.microsoft.com/azure/communication-services/quickstarts/email/connect-email-communication-resource)
1. Send a test email using the custom email address as a sender by following this document: [Send an email via ACS](https://learn.microsoft.com/azure/communication-services/quickstarts/email/send-email)

## Resources

- [Azure Communication Service](https://learn.microsoft.com/azure/communication-services/overview)
- [Create your first Azure Email Communication Service](https://learn.microsoft.com/azure/communication-services/quickstarts/email/create-email-communication-resource)
- [Playlist: Get started with Azure Communication Services](https://www.youtube.com/playlist?list=PLWZJrkeLOrbbncf_O8WRbZud7cKZRZlcc)
