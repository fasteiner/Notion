function New-NotionToDoBlock
{
    <#
    .SYNOPSIS
        Creates a new Notion to-do block object.

    .DESCRIPTION
        This function creates a new instance of the notion_to_do_block class.
        You can create an empty to-do block, provide rich text content, or provide rich text content and a checked state.

    .PARAMETER RichText
        The rich text content for the to-do item.

    .PARAMETER Checked
        Indicates whether the to-do item is checked.

    .EXAMPLE
        New-NotionToDoBlock

    .EXAMPLE
        New-NotionToDoBlock -RichText "Buy milk"

    .EXAMPLE
        New-NotionToDoBlock -RichText "Buy milk" -Checked $true

    .OUTPUTS
        notion_to_do_block
    #>
    [CmdletBinding(DefaultParameterSetName = 'None')]
    param (
        [Parameter(Mandatory = $true)]
        [Alias("Text", "RichText", "Content")]
        [object]$rich_text,
        [switch]$Checked,
        [notion_color]$Color = [notion_color]::default

    )

    return [notion_to_do_block]::ConvertFromObject(
        @{
            to_do = $PSBoundParameters
        }
    )
}
