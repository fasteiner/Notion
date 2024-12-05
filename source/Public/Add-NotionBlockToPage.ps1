function Add-NotionBlockToPage
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The parent page to add the block to")]
        [notion_page] $Page,
        [Parameter(Mandatory = $true, HelpMessage = "The block to add to the page")]
        [notion_block[]] $Block
    )
    
    process
    {
        Write-Debug "Adding block(s) to page $($Page.id)"
        $blocks = $block | ConvertTo-Json -Depth 10 -EnumsAsStrings
        return Invoke-NotionApiCall -Uri "/blocks/$($Page.id)/children" -Method PATCH -body $blocks
    }
}
