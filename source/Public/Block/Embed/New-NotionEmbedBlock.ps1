function New-NotionEmbedBlock
{
    <#
    .SYNOPSIS
        Creates a new Notion embed block object.

    .DESCRIPTION
        This function creates a new instance of the notion_embed_block class.
        You can create an empty embed block, provide a URL, or provide both a URL and a caption.

    .PARAMETER Url
        The URL to be embedded in the block.

    .PARAMETER Caption
        The caption (rich_text[] or object) to be displayed for the embed block.

    .EXAMPLE
        New-NotionEmbedBlock -Url "https://example.com"

    .EXAMPLE
        New-NotionEmbedBlock -Url "https://example.com" -Caption "Example caption"

    .EXAMPLE
        New-NotionEmbedBlock

    .OUTPUTS
        notion_embed_block
    #>
    [CmdletBinding(DefaultParameterSetName = 'None')]
    param (
        [Parameter(ParameterSetName = 'BothParams', Mandatory = $true, HelpMessage = 'URL to be embedded in the block.')]
        [string]$Url,

        [Parameter(ParameterSetName = 'BothParams', Mandatory = $false, HelpMessage = 'Caption for the embed block.')]
        [object]$Caption
    )

    if ($PSBoundParameters.ContainsKey('Url') -and $PSBoundParameters.ContainsKey('Caption'))
    {
        $obj = [notion_embed_block]::ConvertFromObject(
            @{
                embed = $PSBoundParameters
            }
        )
    }
    elseif ($PSBoundParameters.ContainsKey('Url'))
    {
        $obj = [notion_embed_block]::new($Url)
    }
    else
    {
        $obj = [notion_embed_block]::new()
    }
    return $obj
}
