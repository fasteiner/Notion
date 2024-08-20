function Get-TSNotionBlockChildren {
    [alias("Get-TSNotionPageChildren")]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "Block" , HelpMessage = "The block to get the children from")]
        [Block] $Block,
        [Parameter(Mandatory = $true, ParameterSetName = "Id" , HelpMessage = "The block Id to get the children from")]
        [string] $BlockId
    )

    process {
        if ($PSCmdlet.ParameterSetName -eq "Block") {
            $BlockId = $Block.id
        }

        $children = Invoke-TSNotionApiCall -Uri "/blocks/$BlockId/children" -Method GET
        return $children
    }
}
