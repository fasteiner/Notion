function New-NotionDividerBlock
{
    <#
    .SYNOPSIS
        Creates a new Notion divider block object.

    .DESCRIPTION
        This function creates a new instance of the notion_divider_block class.
        The divider block does not require any parameters.

    .EXAMPLE
        New-NotionDividerBlock

    .OUTPUTS
        notion_divider_block
    #>
    [CmdletBinding()]
    param ()

    $obj = [notion_divider_block]::new()
    return $obj
}
