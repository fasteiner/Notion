function New-NotionBulletedListItemBlock
{
    <#
    .SYNOPSIS
        Creates a new Notion bulleted list item block object.

    .DESCRIPTION
        This function creates a new instance of the notion_bulleted_list_item_block class.
        You can create an empty bulleted list item block, or provide rich text and an optional color.

    .PARAMETER RichText
        The rich text content for the bulleted list item.

    .PARAMETER Color
        The color for the bulleted list item. Default is "default".

    .EXAMPLE
        New-NotionBulletedListItemBlock -RichText "Item 1" -Color "red"

    .EXAMPLE
        New-NotionBulletedListItemBlock -RichText "Item 2"

    .EXAMPLE
        New-NotionBulletedListItemBlock

    .OUTPUTS
        notion_bulleted_list_item_block
    #>
    [CmdletBinding(DefaultParameterSetName = 'None')]
    param (
        [Parameter(ParameterSetName = 'WithText', Mandatory = $true)]
        [object]$RichText,

        [Parameter(ParameterSetName = 'WithText')]
        [object]$Color
    )

    if ($PSCmdlet.ParameterSetName -eq 'WithText')
    {
        if ($PSBoundParameters.ContainsKey('Color'))
        {
            $obj = [notion_bulleted_list_item_block]::new($RichText, $Color)
        }
        else
        {
            $obj = [notion_bulleted_list_item_block]::new($RichText)
        }
    }
    else
    {
        $obj = [notion_bulleted_list_item_block]::new()
    }
    return $obj
}
