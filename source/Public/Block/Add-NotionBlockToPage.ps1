function Add-NotionBlockToPage
{
    <#
    .SYNOPSIS
    Adds one or more Notion blocks to a specified Notion page.

    .DESCRIPTION
    The Add-NotionBlockToPage function allows adding Notion blocks to an existing Notion page. 
    The function takes a notion_page object representing the parent page and one or more 
    notion_block objects representing the content to be added. It then makes an API request 
    to update the page with the new blocks.

    .PARAMETER Page
    Specifies the parent Notion page to which the block(s) will be added.
    Type: notion_page
    Required: Yes
    Position: Named
    Accept pipeline input: No
    ParameterSetName: Page
    Help Message: The parent page to add the block to.

    .PARAMETER PageID
    Specifies the page id of the parent page.
    Type: string
    Required: Yes
    Position: Named
    Accept pipeline input: No
    ParameterSetName: PageID
    Help Message: The page id of the parent page.

    .PARAMETER Block
    Specifies the Notion block(s) to be added to the page.
    Type: notion_block[]
    Required: Yes
    Position: Named
    Accept pipeline input: No
    Help Message: The block to add to the page.

    .EXAMPLE
    
    $Page = Get-NotionPage -Id "12345678-90ab-cdef-1234-567890abcdef"
    $Block = New-NotionBlock -Type "paragraph" -Text "Hello, Notion!"
    Add-NotionBlockToPage -Page $Page -Block $Block

    Description: This example retrieves a Notion page by ID and creates a new paragraph 
    block, then adds it to the page.

    .EXAMPLE
    
    $Page = Get-NotionPage -Id "12345678-90ab-cdef-1234-567890abcdef"
    $Block1 = New-NotionBlock -Type "heading_1" -Text "Main Heading"
    $Block2 = New-NotionBlock -Type "paragraph" -Text "This is a paragraph under the heading."
    Add-NotionBlockToPage -Page $Page -Block @($Block1, $Block2)

    Description: This example retrieves a Notion page and adds a heading block followed 
    by a paragraph block to it.

    .OUTPUTS
    The function returns the response from the Notion API after attempting to add 
    the blocks to the specified page.

    .NOTES
    - This function currently requires a notion_page object as input. Future updates 
    may add support for specifying a Page ID directly.
    - The function converts the blocks into JSON before making an API request.

    .LINK
    https://developers.notion.com/reference/patch-block-children
    #>
    [OutputType([notion_block[]])]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The parent page to add the block to", ParameterSetName = "Page")]
        [notion_page] $Page,
        [Parameter(Mandatory = $true, HelpMessage = "The page id of the parent page", ParameterSetName= "PageID")]
        $pageID,
        [Parameter(Mandatory = $true, HelpMessage = "The block to add to the page")]
        [notion_block[]] $Block
    )
    
    process
    {
        Write-Debug "Adding block(s) to page $($Page.id)"
        $pageID ??= $Page.id
        $body = @{
            children = @($Block)
        }
        $body = $body | Remove-NullValuesFromObject
        $response =  Invoke-NotionApiCall -Uri "/blocks/$($Page.id)/children" -Method PATCH -body $body
        return [notion_block[]]@($response.foreach({ [notion_block]::ConvertFromObject($_) }))
    }
}
