function New-NotionRichTextEquation
{
    <#
    .SYNOPSIS
        Creates a Notion rich text object of type "equation".

    .DESCRIPTION
        Wraps the [rich_text_equation] class to create rich text equation objects with optional annotations and link information.

    .PARAMETER Expression
        The LaTeX expression for the equation.

    .PARAMETER Annotations
        Optional annotation object applied to the equation.

    .PARAMETER Link
        Optional hyperlink associated with the equation.

    .OUTPUTS
        [rich_text_equation]
    #>
    [CmdletBinding()]
    [OutputType([rich_text_equation])]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]
        $Expression,

        [Parameter(Position = 1)]
        [object]
        $Annotations
    )

    $payload = @{
        type        = 'equation'
        equation    = @{ 
            expression = $Expression 
        }
        annotations = $Annotations
    }

    return [rich_text]::ConvertFromObject($payload)
}
