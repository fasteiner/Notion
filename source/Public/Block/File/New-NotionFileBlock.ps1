function New-NotionFileBlock
{
    <#
    .SYNOPSIS
        Creates a new Notion file block object.

    .DESCRIPTION
        This function creates a new instance of the notion_file_block class.
        You can create an empty file block, provide a hosted file (with name, caption, url, and expiry time),
        provide an external file (with name, caption, and url), or directly assign a file object.

    .PARAMETER Name
        The name of the file.

    .PARAMETER Caption
        The caption (rich_text[] or object) to be displayed for the file.

    .PARAMETER Url
        The URL of the file.

    .PARAMETER ExpiryTime
        The expiry time for hosted files.

    .PARAMETER File
        A notion_hosted_file or notion_external_file object to assign directly.

    .EXAMPLE
        New-NotionFileBlock -Name "example.pdf" -Caption "Example" -Url "https://example.com/file.pdf" -ExpiryTime "2025-12-31T23:59:59Z"

    .EXAMPLE
        New-NotionFileBlock -Name "example.pdf" -Caption "Example" -Url "https://example.com/file.pdf"

    .EXAMPLE
        New-NotionFileBlock -File $notionFileObject

    .EXAMPLE
        New-NotionFileBlock

    .OUTPUTS
        notion_file_block
    #>
    [CmdletBinding(DefaultParameterSetName = 'None')]
    param (
        [Parameter(ParameterSetName = 'Hosted', Mandatory = $true)]
        [Parameter(ParameterSetName = 'External', Mandatory = $true)]
        [string]$Name,

        [Parameter(ParameterSetName = 'Hosted', Mandatory = $true, HelpMessage = 'The caption of the file block.')]
        [Parameter(ParameterSetName = 'External', Mandatory = $true, HelpMessage = 'The caption of the file block.')]
        $Caption,

        [Parameter(ParameterSetName = 'Hosted', Mandatory = $true, HelpMessage = 'An authenticated HTTP GET URL to the file.')]
        [Parameter(ParameterSetName = 'External', Mandatory = $true)]
        [string]$Url,

        [Parameter(ParameterSetName = 'Hosted', HelpMessage = 'The date and time when the link expires.', Mandatory = $true)]
        [object]$ExpiryTime,

        [Parameter(ParameterSetName = 'File', Mandatory = $true)]
        [object]$File
    )

    Write-Verbose "ParameterSetName: $($PSCmdlet.ParameterSetName)"
    if ($PSCmdlet.ParameterSetName -eq 'Hosted')
    {
        $obj = [notion_file_block]::new($Name, $Caption, $Url, $ExpiryTime)
    }
    elseif ($PSCmdlet.ParameterSetName -eq 'External')
    {
        $obj = [notion_file_block]::new($Name, $Caption, $Url)
    }
    elseif ($PSCmdlet.ParameterSetName -eq 'File')
    {
        $obj = [notion_file_block]::new($File)
    }
    else
    {
        $obj = [notion_file_block]::new()
    }
    return $obj
}
