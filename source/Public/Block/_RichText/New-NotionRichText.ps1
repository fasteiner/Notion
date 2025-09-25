function New-NotionRichText
{
    <#
    .SYNOPSIS
        Creates a new Notion rich text block object.

    .DESCRIPTION
        This function creates a new instance of the rich_text class.
        You can create an empty rich text block, provide text content, or provide text content with annotations and a link.

    .PARAMETER Text
        The text content for the rich text block.

    .PARAMETER Annotations
        The annotations (bold, italic, etc.) for the rich text block. If not specified, the properties of the parent object are used.

    .PARAMETER Link
        The link object or URL for the rich text block.

    .EXAMPLE
        New-NotionRichText

        Creates an empty rich text object.

    .EXAMPLE
        New-NotionRichText -Text "Hello World"

        Creates a rich text object with the specified text "Hello World".

    .EXAMPLE
        $annotations = New-NotionRichTextAnnotation -Bold -Color "blue"
        New-NotionRichText -Text "Hello World" -Annotations $annotations -Link "https://example.com"

        Creates a rich text object with the specified text, annotations, and link.

    .OUTPUTS
        [rich_text]
    #>
    [CmdletBinding()]
    [OutputType([rich_text[]])]
    param (
        [Parameter(Position = 1, HelpMessage = "If not specified, the properties of the parent object are used" )]
        [Parameter(ParameterSetName = "Text")]
        [Parameter(ParameterSetName = "Equation" )]
        [object]$Annotations,

        [Parameter(ParameterSetName = "Text", Position = 2 )]
        [string]$Text,

        [Parameter(ParameterSetName = "Equation" )]
        [string]$Expression,

        [Parameter(ParameterSetName = "ConvertFromMarkdown", Position = 2 )]
        [string]$MarkdownText,

        [Parameter(ParameterSetName = "Text")]
        [object]$Link
    )

    switch ($PSCmdlet.ParameterSetName)
    {
        "Text"
        {
            return New-NotionRichTextText @PSBoundParameters
        }
        "Equation"
        {
            return New-NotionRichTextEquation @PSBoundParameters
        }

        "ConvertFromMarkdown"
        {
            throw [System.NotImplementedException]::new("Markdown conversion is not yet implemented.")
            return @()
        }

        default
        {
            throw "Unsupported parameter set: $($PSCmdlet.ParameterSetName)"
        }
    }
}
