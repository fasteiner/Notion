
function New-NotionBookmarkBlock
{
    <#
        .SYNOPSIS
            Creates a new Notion bookmark block object.
        
        .DESCRIPTION
            The New-NotionBookmarkBlock function instantiates a new notion_bookmark_block object.
            You can optionally provide a URL and/or a caption for the bookmark block.
        
        .PARAMETER Url
            The URL to associate with the bookmark block.
        
        .PARAMETER Caption
            The caption to display for the bookmark block.
        
        .EXAMPLE
            New-NotionBookmarkBlock -Url "https://example.com" -Caption "Example Site"
        
            Creates a new bookmark block with the specified URL and caption.
        
        .EXAMPLE
            New-NotionBookmarkBlock -Url "https://example.com"
        
            Creates a new bookmark block with only the specified URL.

        .OUTPUTS
            [notion_bookmark_block]
            Returns a new instance of the notion_bookmark_block object.
        
        .NOTES
            
        #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    [OutputType([void])]
    param (
        [Parameter(ParameterSetName = 'Default', HelpMessage = 'The URL for the bookmark block.')]
        [string]$Url,
    
        [Parameter(ParameterSetName = 'Default', HelpMessage = 'The caption for the bookmark.')]
        [object]$Caption
    )
    
    if ($PSBoundParameters.ContainsKey('Caption') -and $PSBoundParameters.ContainsKey('Url'))
    {
        $obj = [notion_bookmark_block]::new($Caption, $Url)
    }
    elseif ($PSBoundParameters.ContainsKey('Url'))
    {
        $obj = [notion_bookmark_block]::new($Url)
    }
    else
    {
        $obj = [notion_bookmark_block]::new()
    }
    return $obj
}
