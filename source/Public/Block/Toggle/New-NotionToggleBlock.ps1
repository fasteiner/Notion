function New-NotionToggleBlock
{
    <#
    .SYNOPSIS
        Creates a new Notion toggle block object.

    .DESCRIPTION
        This function creates a new instance of the notion_toggle_block class.
        You can create an empty toggle block, or provide rich text and an optional color.

    .PARAMETER RichText
        The rich text content for the toggle block.

    .PARAMETER Color
        The color for the toggle block. Default is "default".

    .EXAMPLE
        New-NotionToggleBlock

    .EXAMPLE
        New-NotionToggleBlock -RichText "Details"

    .EXAMPLE
        New-NotionToggleBlock -RichText "Details" -Color "gray"

    .OUTPUTS
        notion_toggle_block
    #>
    [CmdletBinding(DefaultParameterSetName = 'None')]
    param (
        [Parameter(ParameterSetName = 'WithText', Mandatory = $true)]
        [object[]]$RichText,

        [Parameter(ParameterSetName = 'WithText')]
        $Color = "default"
    )

    if ($PSCmdlet.ParameterSetName -eq 'WithText')
    {
        $obj = [notion_toggle_block]::new($RichText, $Color)
    }
    else
    {
        $obj = [notion_toggle_block]::new()
    }
    return $obj
}
