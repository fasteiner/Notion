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
    [CmdletBinding(DefaultParameterSetName = 'None')]
    param (
        [Parameter(ParameterSetName = 'WithText', Mandatory = $true, Position = 0 )]
        [Parameter(ParameterSetName = 'WithTextAnnotations', Mandatory = $true)]
        [Parameter(ParameterSetName = 'WithTextAnnotationsAndLink', Mandatory = $true )]
        [string]$Text,

        [Parameter(ParameterSetName = 'WithTextAnnotations', Mandatory = $true, Position = 1 )]
        [Parameter(ParameterSetName = 'WithTextAnnotationsAndLink', Mandatory = $true, Position = 1 )]
        [object]$Annotations,

        [Parameter(ParameterSetName = 'WithTextAnnotationsAndLink', Mandatory = $true, Position = 2 )]
        [object]$Link
    )

    write-Host -ForegroundColor Cyan $PSCmdlet.ParameterSetName
    if ($PSCmdlet.ParameterSetName -eq 'WithTextAnnotationsAndLink')
    {
        $obj = [rich_text]::new($Text, $Annotations, $Link)
    }
    elseif ($PSCmdlet.ParameterSetName -eq 'WithTextAnnotations')
    {
        $obj = [rich_text]::new($Text, $Annotations)
    }
    elseif ($PSCmdlet.ParameterSetName -eq 'WithText')
    {
        $obj = [rich_text_text]::new($Text)
    }
    else
    {
        $obj = [rich_text_text]::new()
    }
    return $obj
}
