function New-NotionColumnBlock
{
    <#
    .SYNOPSIS
        Creates a new Notion column block object.

    .DESCRIPTION
        This function creates a new instance of the notion_column_block class.
        You can create an empty column block or provide child blocks for the column.

    .PARAMETER Children
        The child blocks to include in the column.

    .EXAMPLE
        New-NotionColumnBlock -Children $childBlocks

    .EXAMPLE
        New-NotionColumnBlock

    .OUTPUTS
        notion_column_block
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(ParameterSetName = 'Default')]
        [object[]]$Children
    )

    if ($PSBoundParameters.ContainsKey('Children'))
    {
        $obj = [notion_column_block]::new($Children)
    }
    else
    {
        $obj = [notion_column_block]::new()
    }
    return $obj
}
