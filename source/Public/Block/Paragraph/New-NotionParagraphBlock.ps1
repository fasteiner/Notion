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

    .EXAMPLE
        New-NotionParagraphBlock -RichText "This is a paragraph."

    .EXAMPLE
        New-NotionParagraphBlock -RichText "This is a paragraph." -Color "yellow"

    .OUTPUTS
        notion_paragraph_block
    #>
    [CmdletBinding(DefaultParameterSetName = 'None')]
    param (
        [Parameter(ParameterSetName = 'WithText', Mandatory = $true)]
        [Parameter(ParameterSetName = 'WithTextAndColor', Mandatory = $true)]
        [object[]]$RichText,

        [Parameter(ParameterSetName = 'WithTextAndColor')]
        $Color = "default"
    )

    if ($PSCmdlet.ParameterSetName -eq 'WithTextAndColor')
    {
        $obj = [notion_paragraph_block]::new($RichText, $Color)
    }
    elseif ($PSCmdlet.ParameterSetName -eq 'WithText')
    {
        $obj = [notion_paragraph_block]::new($RichText)
    }
    else
    {
        $obj = [notion_paragraph_block]::new()
    }
    return $obj
}
