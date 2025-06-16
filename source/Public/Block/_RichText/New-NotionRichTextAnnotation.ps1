function New-NotionRichTextAnnotation
{
    <#
    .SYNOPSIS
        Creates a new annotation object for Notion rich text.

    .DESCRIPTION
        This function creates a new instance of the annotation class.
        You can create an empty annotation, provide an object with annotation properties,
        or specify all annotation properties individually.

        ***
        Attention: Due an API limitation, the color can only be set for foreground text, or background, not both.
                   Hopefully this will change in the future.
        ***

    .PARAMETER Annotations
        An object with annotation properties (bold, italic, strikethrough, underline, code, color).

    .PARAMETER Bold
        Indicates if the text is bold.

    .PARAMETER Italic
        Indicates if the text is italic.

    .PARAMETER Strikethrough
        Indicates if the text is strikethrough.

    .PARAMETER Underline
        Indicates if the text is underlined.

    .PARAMETER Code
        Indicates if the text is code.

    .PARAMETER Color
        The color for the annotation (notion_color).

    .EXAMPLE
        New-NotionRichTextAnnotation
        
        Creates an empty annotation object.
    .EXAMPLE
        New-NotionRichTextAnnotation -Annotations @{ bold = $true; color = "red" }

        Creates an annotation object with specified properties from a hashtable.

    .EXAMPLE
        New-NotionRichTextAnnotation -Bold -Color "blue"

        Creates an annotation object with bold text and blue color.

    .EXAMPLE
        New-NotionRichTextAnnotation -Underline -Color "purple_background"

        Creates an annotation object with underlined text and purple background color.

    .OUTPUTS
        [notion_annotation]
    #>
    [CmdletBinding(DefaultParameterSetName = 'None')]
    param (
        [Parameter(ParameterSetName = 'WithObject', Mandatory = $true)]
        [object]$Annotations,

        [Parameter(ParameterSetName = 'WithProperties', HelpMessage = "Whether the text is bolded.")]
        [switch]$Bold = $false,

        [Parameter(ParameterSetName = 'WithProperties', HelpMessage = "Whether the text is italicized.")]
        [switch]$Italic = $false,

        [Parameter(ParameterSetName = 'WithProperties', HelpMessage = "Whether the text is strikethroughed.")]
        [switch]$Strikethrough = $false,

        [Parameter(ParameterSetName = 'WithProperties', HelpMessage = "Whether the text is underlined.")]
        [switch]$Underline = $false,

        [Parameter(ParameterSetName = 'WithProperties', HelpMessage = "Whether the text is code style.")]
        [switch]$Code = $false,

        [Parameter(ParameterSetName = 'WithProperties', HelpMessage = "Color of the text. Possible values include  blue|blue_background|brown|brown_background|default|gray|gray_background|green|green_background|orange|orange_background|pink|pink_background|purple|purple_background|red|red_background|yellow|yellow_background" )]
        [ValidateSet("default", "gray", "brown", "orange", "yellow", "green", "blue", "purple", "pink", "red", "gray_background", "brown_background", "orange_background", "yellow_background", "green_background", "blue_background", "purple_background", "pink_background", "red_background")]
        [string]$Color = "default"
    )

    if ($PSCmdlet.ParameterSetName -eq 'WithObject')
    {
        $obj = [notion_annotation]::new($Annotations)
    }
    elseif ($PSCmdlet.ParameterSetName -eq 'WithProperties')
    {
        $obj = [notion_annotation]::new($Bold, $Italic, $Strikethrough, $Underline, $Code, $Color)
    }
    else
    {
        $obj = [notion_annotation]::new()
    }
    return $obj
}
