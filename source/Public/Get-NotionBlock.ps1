function Get-NotionBlock() {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The block to get the children from", ParameterSetName = "Object")]
        [notion_block] $Block,
        [Parameter(Mandatory = $true, HelpMessage = "The block Id to get the children from", ParameterSetName = "ID")]
        [string] $BlockId,
        $maxDepth = 5
    )

    process {
        if ($PSCmdlet.ParameterSetName -eq "Object") {
            $BlockId = $Block.id
        }
        $block = Invoke-NotionApiCall -Uri "/blocks/$BlockId" -Method GET
        $block = [notion_block]::ConvertFromObject($block)
        if($block.has_children -and $maxDepth -gt 0)
        {
            $objects = Get-NotionBlockChildren -Block $block
            $children = $objects | Get-NotionBlock -maxDepth ($maxDepth - 1)
            $block.addChildren($children)
        }
        return $block
    }
}
