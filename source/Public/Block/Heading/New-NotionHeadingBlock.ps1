function New-NotionHeadingBlock
{
    <#
    .SYNOPSIS
    Creates a new Notion heading.
    
    .DESCRIPTION
    The New-NotionHeadingBlock function creates a new heading for a Notion page with specified text, color, level, and toggleable option.
    
    .PARAMETER Text
    The text of the heading. This parameter is mandatory.
    
    .PARAMETER Color
    The color of the heading. This parameter is optional and defaults to "default".
    
    .PARAMETER Level
    The level of the heading (1-3). This parameter is mandatory.
    
    .PARAMETER is_toggleable
    Specifies if the heading is toggleable. This parameter is optional.
    
    .EXAMPLE
    PS> New-NotionHeadingBlock -Text "My heading" -Level 1
    
    Creates a level 1 heading with the text "My heading" and default color.
    
    .EXAMPLE
    PS> New-NotionHeadingBlock -Text "My heading" -Color "blue" -Level 2 -is_toggleable $true
    
    Creates a level 2 heading with the text "My heading", blue color, and toggleable option enabled.

    .OUTPUTS
    [notion_heading_block] object
    
    #>
    [CmdletBinding()]
    [Alias("New-NotionHeading")]
    [OutputType([notion_heading_block])]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Text of the heading")]
        $text,
        [Parameter(Mandatory = $false, HelpMessage = "Color of the heading (Defaults to 'default') Possible values are blue|blue_background|brown|brown_background|default|gray|gray_background|green|green_background|orange|orange_background|pink|pink_background|purple|purple_background|red|red_background|yellow|yellow_background" )]
        [ValidateSet("default", "gray", "brown", "orange", "yellow", "green", "blue", "purple", "pink", "red", "gray_background", "brown_background", "orange_background", "yellow_background", "green_background", "blue_background", "purple_background", "pink_background", "red_background")]
        $Color = "default",
        [Parameter(Mandatory = $true, HelpMessage = "Level of the Heading (1-3)")]
        [ValidateRange(1, 3)]
        [int] $Level,
        [Parameter(Mandatory = $false, HelpMessage = "Is the heading toggleable, defaults to false")]
        [switch] $is_toggleable = $false
    )
    
    process
    {
        $heading = [notion_heading_block]::Create($Level, $Text, $color, $is_toggleable)
        return $heading
    }
}
