function Get-NotionBlockChildren {
    <#
    .SYNOPSIS
    Retrieves the children blocks of a specified Notion block.

    .DESCRIPTION
    The `Get-NotionBlockChildren` function retrieves all child blocks of a given Notion block by its ID or object representation. It uses the Notion API to fetch the child blocks and converts the response into an array of `notion_block` objects.

    .PARAMETER Block
    Specifies the Notion block object whose children should be retrieved. This parameter is part of the "Block" parameter set and is mandatory when used.

    .PARAMETER BlockId
    Specifies the unique identifier of the Notion block whose children should be retrieved. This parameter is part of the "Id" parameter set and is mandatory when used.

    .PARAMETERSETNAME Block
    The "Block" parameter set allows specifying a Notion block object to derive the `BlockId` for the API call.

    .PARAMETERSETNAME Id
    The "Id" parameter set allows specifying the `BlockId` directly to retrieve the children.

    .OUTPUTS
    [notion_block[]]
    Returns an array of `notion_block` objects representing the child blocks of the specified Notion block.

    .NOTES
    - The function supports two parameter sets for flexibility: specifying a block object or its ID directly.
    - Ensure that the Notion API is properly configured and authorized for use.

    .EXAMPLE
    Get-NotionBlockChildren -BlockId "12345abcde"

    Retrieves the child blocks of the Notion block with the ID `12345abcde`.

    .EXAMPLE
    $block = Get-NotionBlock -Id "67890fghij"
    Get-NotionBlockChildren -Block $block

    Retrieves the child blocks of the specified Notion block object.

    .EXAMPLE
    "12345abcde", "67890fghij" | ForEach-Object { Get-NotionBlockChildren -BlockId $_ }

    Retrieves the child blocks for multiple Notion blocks by their IDs using pipeline input.

    .LINK
    https://developers.notion.com/reference/get-block-children
    
    #>

    [CmdletBinding()]
    [OutputType([notion_block[]])]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = "Block" , HelpMessage = "The block to get the children from")]
        [notion_block] $Block,
        [Parameter(Mandatory = $true, ParameterSetName = "Id" , HelpMessage = "The block Id to get the children from")]
        [alias("Id")]
        [string] $BlockId
    )

    process {
        if ($PSCmdlet.ParameterSetName -eq "Block") {
            $BlockId = $Block.id
        }

        $uri = "/blocks/$BlockId/children"
        $response = Invoke-NotionApiCall -uri $uri -method "GET"
        return [notion_block[]]@($response.foreach({[notion_block]::ConvertFromObject($_)}))
    }
}
