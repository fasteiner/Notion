function New-NotionHeader
{
    <#
    .SYNOPSIS
    Creates a new Notion header.
    
    .DESCRIPTION
    The New-NotionHeader function creates a new header for a Notion page with specified text, color, level, and toggleable option.
    
    .PARAMETER Text
    The text of the header. This parameter is mandatory.
    
    .PARAMETER Color
    The color of the header. This parameter is optional and defaults to "default".
    
    .PARAMETER Level
    The level of the header (1-3). This parameter is mandatory.
    
    .PARAMETER is_toggleable
    Specifies if the header is toggleable. This parameter is optional.
    
    .EXAMPLE
    PS> New-NotionHeader -Text "My Header" -Level 1
    
    Creates a level 1 header with the text "My Header" and default color.
    
    .EXAMPLE
    PS> New-NotionHeader -Text "My Header" -Color "blue" -Level 2 -is_toggleable $true
    
    Creates a level 2 header with the text "My Header", blue color, and toggleable option enabled.

    .OUTPUTS
    [notion_heading_block] object
    
    #>
    [CmdletBinding()]
    [Alias("New-NotionHeading")]
    [OutputType([notion_heading_block])]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Text of the Header")]
        [string] $Text,
        [Parameter(Mandatory = $false, HelpMessage = "Color of the Header")]
        [notion_color] $Color = "default",
        [Parameter(Mandatory = $true, HelpMessage = "Level of the Header (1-3)")]
        [ValidateRange(1, 3)]
        [int] $Level,
        [Parameter(Mandatory = $false, HelpMessage = "Is the Header toggleable")]
        [boolean] $is_toggleable 
    )
    
    process
    {
        $Header = [notion_heading_block]::Create($Level, $Text, $color, $is_toggleable)
        return $Header
    }
}
