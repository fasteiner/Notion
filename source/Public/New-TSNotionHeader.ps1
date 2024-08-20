function New-TSNotionHeader
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "Text of the Header")]
        [string] $Text,
        [Parameter(Mandatory = $false, HelpMessage = "Color of the Header")]
        [notion_color] $Color = "default",
        [Parameter(Mandatory = $true, HelpMessage = "Level of the Header (1-3)")]
        [int] $Level,
        [Parameter(Mandatory = $false, HelpMessage = "Is the Header toggleable")]
        [boolean] $is_toggleable 
    )
    
    begin
    {
    }
    process
    {
        $Header = [Heading]::new($level, $text, $color, $is_toggleable)
        return $Header
    }
    end
    {
    }
}
