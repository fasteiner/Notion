function Get-TSNotionBlockChildren {
    [alias("Get-TSNotionPageChildren")]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "Block" , HelpMessage = "The block to get the children from")]
        [Block] $Block,
        [Parameter(Mandatory = $true, ParameterSetName = "Id" , HelpMessage = "The block Id to get the children from")]
        [string] $BlockId,
        [int] $maxDepth = 5
    )

    process {
        if ($PSCmdlet.ParameterSetName -eq "Block") {
            $BlockId = $Block.id
        }

        $childrenRaw = Invoke-TSNotionApiCall -Uri "/blocks/$BlockId/children" -Method GET
        $children = $childrenRaw | ConvertTo-TSNotionObject
        if($maxDepth -gt 0)
        {
            foreach($child in $children)
            {
                if($child.has_children)
                {
                    $child.addChildren((Get-TSNotionBlockChildren -Block $child -maxDepth ($maxDepth - 1)))
                }
            }
        }
        return $children
    }
}
