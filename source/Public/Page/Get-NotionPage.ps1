function Get-NotionPage
{
    <#
    .SYNOPSIS
        Retrieves properties of a Notion page using the Notion API.
    
    .DESCRIPTION
        The `Get-NotionPage` function retrieves  a specified Notion page by making a GET request
        to the Notion API's `/v1/pages/{page_id}` endpoint, utilizing the `Invoke-NotionApiCall` function.
    
    .PARAMETER PageId
        The unique identifier of the Notion page. This is a required parameter.

    .PARAMETER Raw
        If this switch is enabled, the raw response from the API call will be returned.
    
    .EXAMPLE
        $pageId = "d5f1d1a5-7b16-4c2a-a2a6-7d43574a1787"
        Get-NotionPage -PageId $pageId
    
        This example retrieves the page with the specified ID.
    
    .NOTES
        - Ensure that the Notion API integration has access to the page.
        - The API token and version are handled within the `Invoke-NotionApiCall` function.

        - If you need the page content use [Get-NotionPageChildren](./Get-NotionPageChildren.ps1) to get the children of the page.

    .OUTPUTS
        notion_page

    .LINK
        https://developers.notion.com/reference/retrieve-a-page-property-item
    #>
    [CmdletBinding()]
    [OutputType([notion_page])]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias("Id")]
        [string]$PageId

    )
    
    if (-not (Test-NotionApiSettings $MyInvocation.MyCommand.Name))
    {
        return
    }

    # Construct the API endpoint URL
    $url = "/pages/$PageId"

    # Make the API call using the Invoke-NotionApiCall function
    $response = Invoke-NotionApiCall -uri $url -method "GET"

    # Return the response to the caller
    $pageObj = [notion_page]::ConvertFromObject($response)
    return $pageObj
}
