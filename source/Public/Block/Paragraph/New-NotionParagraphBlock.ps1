function New-NotionParagraphBlock
{
    <#
    .SYNOPSIS
        Creates a new Notion paragraph block object.

        .DESCRIPTION
        This function creates a new instance of the notion_paragraph_block class.
        You can create an empty paragraph block, provide rich text content, or provide rich text content and a color.

        .PARAMETER RichText
        The rich text content for the paragraph block.

    .PARAMETER Color
        The color for the paragraph block.

    .EXAMPLE
        New-NotionParagraphBlock

        Creates a new empty Notion paragraph block.

    .EXAMPLE
        New-NotionParagraphBlock -RichText "This is a paragraph."

        Creates a new Notion paragraph block with the specified rich text content.

    .EXAMPLE
        New-NotionParagraphBlock -RichText "This is a paragraph." -Color "yellow"

        Creates a new Notion paragraph block with the specified rich text content and color.

    .OUTPUTS
    notion_paragraph_block
    #>
    [Alias('New-NotionTextBlock')]
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, HelpMessage = "The rich text content for the paragraph block.")]
        [Alias('Text', 'Content')]
        [object[]]$RichText,
        [Parameter(Position = 1, HelpMessage = "The color for the paragraph block.")]
        $Color = "default"
    )
    
    if ($RichText -and $Color)
    {
        $obj = [notion_paragraph_block]::new($RichText, $Color)
    }
    elseif ($RichText)
    {
        $obj = [notion_paragraph_block]::new($RichText)
    }
    else
    {
        $obj = [notion_paragraph_block]::new()
    }
    return $obj
}
