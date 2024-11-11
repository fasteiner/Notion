function Get-TSNotionBlock() {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The block to get the children from", ParameterSetName = "Object")]
        [Block] $Block,
        [Parameter(Mandatory = $true, HelpMessage = "The block Id to get the children from", ParameterSetName = "ID")]
        [string] $BlockId,
        $maxDepth = 5
    )

    process {
        if ($PSCmdlet.ParameterSetName -eq "Object") {
            $BlockId = $Block.id
        }
        $block = Invoke-TSNotionApiCall -Uri "/blocks/$BlockId" -Method GET
        $block = [block]::ConvertFromObject($block)
        if($block.has_children -and $maxDepth -gt 0)
        {
            $objects = Get-TSNotionBlockChildren -Block $block
            $children = $objects | Get-TSNotionBlock -maxDepth ($maxDepth - 1)
            $block.addChildren($children)
        }
        return $block
    }
}
