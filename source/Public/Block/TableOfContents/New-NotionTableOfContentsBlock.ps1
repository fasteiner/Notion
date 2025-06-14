function New-NotionTableOfContentsBlock
{
    <#
    .SYNOPSIS
        Creates a new Notion table of contents block object.

    .DESCRIPTION
        This function creates a new instance of the notion_table_of_contents_block class.
        You can create a table of contents block with a specific color or use the default color.

    .PARAMETER Color
        The color for the table of contents block. Default is "default".

    .EXAMPLE
        New-NotionTableOfContentsBlock

    .EXAMPLE
        New-NotionTableOfContentsBlock -Color "gray"

    .OUTPUTS
        notion_table_of_contents_block
    #>
    [CmdletBinding(DefaultParameterSetName = 'None')]
    param (
        [Parameter(ParameterSetName = 'WithColor')]
        $Color = "default"
    )

    if ($PSCmdlet.ParameterSetName -eq 'WithColor')
    {
        $obj = [notion_table_of_contents_block]::new($Color)
    }
    else
    {
        $obj = [notion_table_of_contents_block]::new()
    }
    return $obj
}
