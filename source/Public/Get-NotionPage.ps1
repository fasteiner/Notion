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
    
    .PARAMETER maxDepth
        The maximum depth of subblocks objects. The default is 5.    
    
    .EXAMPLE
        $pageId = "d5f1d1a5-7b16-4c2a-a2a6-7d43574a1787"
        Get-NotionPage -PageId $pageId
    
        This example retrieves the page with the specified ID.
    
    .NOTES
        - Ensure that the Notion API integration has access to the page.
        - The API token and version are handled within the `Invoke-NotionApiCall` function.
    
    .LINK
        https://developers.notion.com/reference/retrieve-a-page-property-item
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [Alias("Id")]
        [string]$PageId,
        [Parameter(ParameterSetName = "Class")]
        [int]$maxDepth = 5
    )

    # Construct the API endpoint URL
    $url = "/pages/$PageId"

    try
    {
        # Make the API call using the Invoke-NotionApiCall function
        $response = Invoke-NotionApiCall -uri $url -method "GET"

        # Return the response to the caller
        $pageObj = [notion_page]::ConvertFromObject($response)
        $blocks = Get-NotionBlockChildren -BlockId $pageObj.id
        # $children = $blocks | Get-NotionBlockChildren -maxDepth ($maxDepth - 1)
        # $pageObj.addChildren($children)
        return @($pageObj, $blocks)
    }
    catch
    {
        # Handle any errors that occur during the API call

        # Write-Error "Failed to retrieve the page property."
        Get-Error
    }
}
