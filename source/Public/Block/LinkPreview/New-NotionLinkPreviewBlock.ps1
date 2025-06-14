function New-NotionLinkPreviewBlock {
    <#
    .SYNOPSIS
        Creates a new Notion link preview block object.

    .DESCRIPTION
        This function creates a new instance of the notion_link_preview_block class.
        You can create an empty link preview block or provide a URL for the preview.

    .PARAMETER Url
        The URL to be used in the link preview block.

    .EXAMPLE
        New-NotionLinkPreviewBlock -Url "https://example.com"

    .EXAMPLE
        New-NotionLinkPreviewBlock

    .OUTPUTS
        notion_link_preview_block
    #>
    [CmdletBinding(DefaultParameterSetName = 'None')]
    param (
        [Parameter(ParameterSetName = 'WithUrl', Mandatory = $true)]
        [string]$Url
    )

    if ($PSCmdlet.ParameterSetName -eq 'WithUrl') {
        $obj = [notion_link_preview_block]::new($Url)
    } else {
        $obj = [notion_link_preview_block]::new()
    }
    return $obj
}
