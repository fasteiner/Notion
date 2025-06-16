function New-NotionQuoteBlock
{
    <#
    .SYNOPSIS
        Creates a new Notion quote block object.

    .DESCRIPTION
        This function creates a new instance of the notion_quote_block class.
        You can create an empty quote block or provide rich text and a color for the quote.

    .PARAMETER RichText
        The rich text content for the quote block.

    .PARAMETER Color
        The color for the quote block. Default is "default".

    .EXAMPLE
        New-NotionQuoteBlock -RichText "This is a quote." -Color "gray"

    .EXAMPLE
        New-NotionQuoteBlock

    .OUTPUTS
        notion_quote_block
    #>
    [CmdletBinding(DefaultParameterSetName = 'None')]
    param (
        [Parameter(ParameterSetName = 'WithText', Mandatory = $true)]
        [object[]]$RichText,

        [Parameter(ParameterSetName = 'WithText')]
        [object]$Color = "default"
    )

    if ($PSCmdlet.ParameterSetName -eq 'WithText')
    {
        $obj = [notion_quote_block]::new($RichText, $Color)
    }
    else
    {
        $obj = [notion_quote_block]::new()
    }
    return $obj
}
