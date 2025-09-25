function New-NotionEmoji
{
    <#
    .SYNOPSIS
        Creates a new Notion emoji object.

    .DESCRIPTION
        This function creates a new instance of the notion_emoji class.
        You can create an empty emoji object or provide an emoji character.

    .PARAMETER Emoji
        The emoji character to be used.

    .EXAMPLE
        New-NotionEmoji

    .EXAMPLE
        New-NotionEmoji "😀"

        Creates a new emoji object with the specified emoji character.
        
        .EXAMPLE
        New-NotionEmoji -Emoji "😀"

        Creates a new emoji object with the specified emoji character.

    .OUTPUTS
        notion_emoji
    #>
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, HelpMessage = 'The emoji character to use.')]
        [string]$Emoji
    )

    $obj = [notion_emoji]::new($Emoji)
    
    return $obj
}
