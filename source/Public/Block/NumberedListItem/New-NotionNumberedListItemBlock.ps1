function New-NotionNumberedListItemBlock
{
    <#
    .SYNOPSIS
        Creates a new Notion numbered list item block object.

    .DESCRIPTION
        This function creates a new instance of the notion_numbered_list_item_block class.
        You can create an empty numbered list item block or provide rich text content for the item.

    .PARAMETER RichText
        The rich text content for the numbered list item.

    .EXAMPLE
        New-NotionNumberedListItemBlock -RichText "Item 1"

    .EXAMPLE
        New-NotionNumberedListItemBlock

    .OUTPUTS
        notion_numbered_list_item_block
    #>
    [CmdletBinding(DefaultParameterSetName = 'None')]
    param (
        [Parameter(ParameterSetName = 'WithText', Mandatory = $true)]
        [object]$RichText
    )

    if ($PSCmdlet.ParameterSetName -eq 'WithText')
    {
        $obj = [notion_numbered_list_item_block]::new($RichText)
    }
    else
    {
        $obj = [notion_numbered_list_item_block]::new()
    }
    return $obj
}
