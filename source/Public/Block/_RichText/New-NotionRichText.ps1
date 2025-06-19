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
        The annotations (bold, italic, etc.) for the rich text block.

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
    param (
        [Parameter(Position = 0 )]
        [ValidateSet("text", "mention", "equation")]
        [string]$Type = "text",

        [Parameter(Position = 1 )]
        [object]$Annotations,

        [Parameter(Position = 2 )]
        [string]$Text,

        [Parameter(Position = 3 )]
        [object]$Link
    )

        $obj = [rich_text]::new($Type, [notion_annotation]::ConvertFromObject($Annotations), $Text, $Link)

    return $obj
}
