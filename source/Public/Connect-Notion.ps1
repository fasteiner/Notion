function Connect-Notion
{
    <#
    .SYNOPSIS
    Connects to the Notion API using the provided Bearer token and URL.
    
    .DESCRIPTION
    The Connect-TSNotion function is used to establish a connection to the Notion API. It requires a Bearer token and the URL to the Notion API. Optionally, you can specify the API version.

    How to obtain an Bearer Token / Notion API Key / Integration Key?
    1. Register a new account at [https://notion.com](https://notion.com)
    2. [https://developers.notion.com](https://developers.notion.com) -> Click "View my integrations"
    3. At "My integrations" click Add (**+**)
    4. Select the name, workspace, type and logo - Click "Save"
    5. Click on "Configure"
    6. Secret -> Click on "Show"
    7. Click on "Copy"
    8. That's your Bearer Token / API Key / Integration Token
    
    .PARAMETER BearerToken
    The Bearer token (aka APIKey) used for authentication. This parameter is mandatory.
    
    .PARAMETER notionURL
    The URL to the Notion API. This parameter is optional and defaults to 'https://api.notion.com/v1'
    
    .PARAMETER APIVersion
    The version of the Notion API to use. Valid values are '2022-02-22' and '2022-06-28'. This parameter is optional and defaults to '2022-06-28'.
    
    .EXAMPLE
    Connect-Notion -BearerToken $secureToken -notionURL "https://api.notion.com/v1" -APIVersion '2022-06-28'
    
    Connects to the Notion API using the specified Bearer token, URL, and API version.
    .EXAMPLE
    $BearerToken = Read-Host -Prompt "Enter your Bearer token" | ConvertTo-Securestring -AsPlainText
    Connect-Notion -BearerToken $BearerToken

    Asks for the API token and connects to the Notion API.
    
    .OUTPUTS
    System.Collections.Hashtable
    Returns a hashtable containing the URL and API version used for the connection.
    
    #>
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The Bearer token used for authentication as secure string")]
        [Alias("bearer")]
        [securestring]$BearerToken,
        [Parameter(Mandatory = $false, HelpMessage = "The URL to Notion e.g. https://api.notion.com/v1")]
        [string]$notionURL = "https://api.notion.com/v1",
        [ValidateSet('2022-02-22', '2022-06-28')]
        [Parameter(Mandatory = $false, HelpMessage = "The API version '2022-02-22' or '2022-06-28'")]
        [string]$APIVersion = '2022-06-28'
    )
    
    # Test connection
    $result = Invoke-NotionApiCall "$notionURL/search" -APIKey $BearerToken -APIVersion $APIVersion -first 1 -method POST -body @{
        "query" = ""
        filter  = @{
            "property" = "object"
            "value"    = "page"
        }
        sort    = @{
            "direction" = "ascending"
            "timestamp" = "last_edited_time"
        }
    }
    if ($result -eq $null)
    {
        Write-Error "Failed to connect to Notion API." -RecommendedAction "Please check your Bearer token and URL." -Category ConnectionError
        return
    }
    $global:NotionAPIKey = $BearerToken
    $global:NotionApiUri = $notionURL
    $global:NotionAPIVersion = $APIVersion
    Write-Host "Successfully connected to Notion API." -ForegroundColor Green

    return @{
        url     = $global:NotionApiUri
        version = $global:NotionAPIVersion
    }
}
