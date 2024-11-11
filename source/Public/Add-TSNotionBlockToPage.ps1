function Add-TSNotionBlockToPage
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The parent page to add the block to")]
        [Page] $Page,
        [Parameter(Mandatory = $true, HelpMessage = "The block to add to the page")]
        [Block[]] $Block
    )
    
    process
    {
        Write-Debug "Adding block(s) to page $($Page.id)"
        $blocks = $block | ConvertTo-Json -Depth 10 -EnumsAsStrings
        return Invoke-TSNotionApiCall -Uri "/blocks/$($Page.id)/children" -Method PATCH -body $blocks
    }
}
