function New-NotionCalloutBlock
{
    <#
    .SYNOPSIS
        Creates a new Notion callout block object.

    .DESCRIPTION
        This function creates a new instance of the notion_callout_block class.
        All supported constructors of the class are covered:
        - No parameters (creates an empty callout)
        - With rich_text, icon, and color

    .PARAMETER RichText
        The rich text content for the callout block.

    .PARAMETER Icon
        The icon (emoji or file) for the callout block.

    .PARAMETER Color
        The color for the callout block.
        
    .EXAMPLE
    New-NotionCalloutBlock -RichText "Hello" -Icon ":bulb:" -Color "yellow"
    
    .EXAMPLE
    New-NotionCalloutBlock
    
    .OUTPUTS
        notion_callout_block
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(ParameterSetName = 'Default', HelpMessage = 'Rich text content array for the callout block.')]
        [Object[]] $RichText,

        [Parameter(ParameterSetName = 'Default', HelpMessage = 'Icon (object). Can be an emoji or a file.')]
        $Icon,

        [Parameter(ParameterSetName = 'Default', HelpMessage = 'Color of the callout block.')]
        [notion_color] $Color = [notion_color]::Default
    )
    $obj = $null
    if ($PSBoundParameters.ContainsKey('RichText') -and $PSBoundParameters.ContainsKey('Icon') -and $PSBoundParameters.ContainsKey('Color'))
    {
        $RichText = [rich_text]::ConvertFromObjects($RichText)
        $Icon = [notion_emoji]::ConvertFromObject($Icon)
        $obj = [notion_callout_block]::new($RichText, $Icon, $Color)
    }
    else
    {
        $obj = [notion_callout_block]::new()
    }
    return $obj
}
