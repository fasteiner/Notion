function Get-NotionPageChildren 
{
    <#
    .SYNOPSIS
    Retrieves the children blocks of a Notion page.

    .DESCRIPTION
    The `Get-NotionPageChildren` function acts as a wrapper for the `Get-NotionBlockChildren` function. It retrieves all child blocks associated with a specific Notion page, given its ID.

    .PARAMETER PageId
    The unique identifier of the Notion page whose children are to be retrieved. This parameter is mandatory.

    .OUTPUTS
    [notion_block[]]
    Returns an array of `notion_block` objects representing the child blocks of the specified Notion page.

    .NOTES
    - This function simplifies the process of retrieving child blocks by accepting a page ID and internally calling the `Get-NotionBlockChildren` function.
    - Ensure that the Notion API is properly configured and authorized for use.

    .EXAMPLE
    Get-NotionPageChildren -PageId "12345abcde"

    Retrieves the child blocks of the Notion page with the ID `12345abcde`.

    .EXAMPLE
    "67890fghij", "11223klmno" | ForEach-Object { Get-NotionPageChildren -PageId $_ }

    Retrieves the child blocks for multiple Notion pages with IDs `67890fghij` and `11223klmno`.

    .EXAMPLE
    $pageIds = @("12345abcde", "67890fghij")
    $pageIds | Get-NotionPageChildren

    Uses pipeline input to retrieve the child blocks for multiple Notion pages.

    .LINK
    https://developers.notion.com/reference/get-block-children
    
    #>

    [CmdletBinding()]
    [OutputType([notion_block[]])]
    param (
        [Parameter(Mandatory = $true, Position=0, HelpMessage = "The ID of the page to get the children from")]
        [Alias("Id")]
        [string]$PageId
    )

    if (-not (Test-NotionApiSettings $MyInvocation.MyCommand.Name))
    {
        return
    }
    
    return (Get-NotionBlockChildren -BlockId $PageId)
}
