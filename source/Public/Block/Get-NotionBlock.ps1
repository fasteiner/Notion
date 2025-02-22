function Get-NotionBlock() 
{
    <#
    .SYNOPSIS
        Retrieves a Notion block and its children up to a specified depth.

    .DESCRIPTION
        The Get-NotionBlock function retrieves a Notion block and its children up to a specified depth. 
        It can accept either a block object or a block ID as input.

    .PARAMETER Block
        The block to get the children from. This parameter is mandatory if using the "Object" parameter set.

    .PARAMETER BlockId
        The block ID to get the children from. This parameter is mandatory if using the "ID" parameter set.

    .PARAMETER maxDepth
        The maximum depth of children to retrieve. The default value is 5.

    .EXAMPLE
        
        $block = Get-NotionBlock -BlockId "some-block-id" -maxDepth 3
        

    .EXAMPLE
    
        $block = Get-NotionBlock -Block $someBlockObject -maxDepth 2
    .OUTPUTS
        [notion_block]
        Returns a notion_block object representing the specified block and its children.

    .NOTES
        This function requires the Invoke-NotionApiCall and Get-NotionBlockChildren functions to be defined.
    .LINK
        https://developers.notion.com/reference/get-block-children
    #>
    [OutputType([notion_block])]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The block to get the children from", ParameterSetName = "Object")]
        [notion_block] $Block,
        [Parameter(Mandatory = $true, HelpMessage = "The block Id to get the children from", ParameterSetName = "ID")]
        [string] $BlockId,
        $maxDepth = 5
    )

    process {
        if ($PSCmdlet.ParameterSetName -eq "Object") 
        {
            $BlockId = $Block.id
        }
        $block = Invoke-NotionApiCall -Uri "/blocks/$BlockId" -Method GET
        $block = [notion_block]::ConvertFromObject($block)
        if ($block.has_children -and $maxDepth -gt 0)
        {
            $objects = Get-NotionBlockChildren -Block $block
            $children = $objects | Get-NotionBlock -maxDepth ($maxDepth - 1)
            $block.addChildren($children)
        }
        return $block
    }
}
