function New-NotionRichTextText
{
    <#
    .SYNOPSIS
        Creates a new Notion rich text block object of type "text".

    .DESCRIPTION
        This function creates a new instance of the rich_text class with type "text".
        It supports adding text content with optional annotations and links.

    .PARAMETER Text
        The text content for the rich text block.

    .PARAMETER Annotations
        The annotations (bold, italic, etc.) for the rich text block. If not specified, the properties of the parent object are used.

    .PARAMETER Link
        The link object or URL for the rich text block.

    .EXAMPLE
        New-NotionRichTextText -Text "Hello World"

        Creates a rich text object with the specified text "Hello World".

    .EXAMPLE
        $annotations = New-NotionRichTextAnnotation -Bold -Color "blue"
        New-NotionRichTextText -Text "Hello World" -Annotations $annotations -Link "https://example.com"

        Creates a rich text object with the specified text, annotations, and link.

    .OUTPUTS
        [rich_text]
    #>
    [CmdletBinding()]
    [OutputType([rich_text])]
    param (
        [Parameter(Position = 0)]
        [string]$Text,

        [Parameter(Position = 1, HelpMessage = "If not specified, the properties of the parent object are used")]
        [object]$Annotations,

        [Parameter(Position = 2)]
        [object]$Link
    )

    return [rich_text]::ConvertFromObjects(
        @{
            type        = "text"
            annotations = $Annotations
            text        = @{
                content = $Text
                link    = $Link
            }
        }
    )
}
