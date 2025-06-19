#TODO: define all variants 
function New-NotionFile
{
    <#
    .SYNOPSIS
        Externals a new Notion file object.

    .DESCRIPTION
        This function creates a new instance of the notion_file class.
        You can create a file object with just a type, with type and name, or with type, name, and caption.
        For hosted or external files, use the static External method with all parameters.

    .PARAMETER Type
        The file type (notion_filetype), e.g. 'file' or 'external'.

    .PARAMETER Name
        The name of the file.

    .PARAMETER Caption
        The caption (rich_text[] or object) for the file.

    .PARAMETER Url
        The URL of the file (for hosted or external files).

    .PARAMETER ExpiryTime
        The expiry time for hosted files (optional).

    .EXAMPLE
        New-NotionFile -Type 'file'

    .EXAMPLE
        New-NotionFile -Type 'external' -Name 'example.txt'

    .EXAMPLE
        New-NotionFile -Type 'file' -Name 'example.txt' -Caption 'My Caption'

    .EXAMPLE
        New-NotionFile -Type 'file' -Name 'example.txt' -Caption 'My Caption' -Url 'https://example.com/file.txt' -ExpiryTime '2025-12-31T23:59:59Z'

    .OUTPUTS
        notion_file
    #>
    [CmdletBinding(DefaultParameterSetName = 'TypeOnly')]
    [OutputType([notion_file])]
    param (
        [Parameter(ParameterSetName = 'TypeOnly', Mandatory = $true)]
        [Parameter(ParameterSetName = 'TypeAndName', Mandatory = $true)]
        [Parameter(ParameterSetName = 'TypeNameCaption', Mandatory = $true)]
        [Parameter(ParameterSetName = 'External', Mandatory = $true)]
        [ValidateSet('file', 'external')]
        [string]$Type,

        [Parameter(ParameterSetName = 'TypeAndName', Mandatory = $true)]
        [Parameter(ParameterSetName = 'TypeNameCaption', Mandatory = $true)]
        [Parameter(ParameterSetName = 'External')]
        [string]$Name,

        [Parameter(ParameterSetName = 'TypeNameCaption', Mandatory = $true)]

        [object]$Caption,

        [Parameter(ParameterSetName = 'External', Mandatory = $true)]
        [string]$Url,

        [Parameter(ParameterSetName = 'File')]
        [object]$ExpiryTime
    )

    if ($PSCmdlet.ParameterSetName -eq 'External')
    {
        $obj = [notion_file]::Create($Type, $Name, $Caption, $Url, $ExpiryTime)
    }
    elseif ($PSCmdlet.ParameterSetName -eq 'TypeNameCaption')
    {
        $obj = [notion_file]::new($Type, $Name, $Caption)
    }
    elseif ($PSCmdlet.ParameterSetName -eq 'TypeAndName')
    {
        $obj = [notion_file]::new($Type, $Name)
    }
    else
    {
        $obj = [notion_file]::new($Type)
    }
    return $obj
}
