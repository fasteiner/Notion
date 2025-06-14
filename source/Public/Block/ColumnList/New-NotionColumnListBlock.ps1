function New-NotionColumnListBlock
{
    <#
    .SYNOPSIS
        Creates a new Notion column list block object.

    .DESCRIPTION
        This function creates a new instance of the notion_column_list_block class.
        You can create an empty column list block or provide child blocks for the column list.

    .PARAMETER Children
        The child blocks to include in the column list.

    .EXAMPLE
        New-NotionColumnListBlock -Children $childBlocks

    .EXAMPLE
        New-NotionColumnListBlock

    .OUTPUTS
        notion_column_list_block
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(ParameterSetName = 'Default')]
        [object[]]$Children
    )

    if ($PSBoundParameters.ContainsKey('Children'))
    {
        $obj = [notion_column_list_block]::new($Children)
    }
    else
    {
        $obj = [notion_column_list_block]::new()
    }
    return $obj
}
