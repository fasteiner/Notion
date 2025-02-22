
function Move-NotionDatabaseToArchive {
    <#
        .SYNOPSIS
        Moves a Notion database to the archive.

        .DESCRIPTION
        The Move-NotionDatabaseToArchive function archives a specified Notion database by setting its archive property to true. 
        This operation is confirmed by the user due to its high impact.

        .PARAMETER DatabaseId
        The ID of the database to archive. This parameter is mandatory.

        .INPUTS
        [string]

        .OUTPUTS
        [notion_database]

        .EXAMPLE
        PS C:\> Move-NotionDatabaseToArchive -DatabaseId "12345"
        This command archives the Notion database with the ID "12345".

        .NOTES
        This function uses the Invoke-NotionApiCall cmdlet to make a PATCH request to the Notion API.
        Attention: Only pages can be restored via the GUI. Databases can only be restored via the API.

        .LINK
        https://developers.notion.com/reference/update-a-database (archive=true)
#>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType([notion_database])]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The ID of the database to archive")]
        [Alias("Id")]
        [string]$DatabaseId
    )

    $body = @{
        archive = $true
    }
    $body = $body | Remove-NullValuesFromObject
    if ($PSCmdlet.ShouldProcess("Database $DatabaseId"))
    { 
        $response = Invoke-NotionApiCall -method PATCH -uri "/databases/$($DatabaseId)" -body $body
        return [notion_database]::ConvertFromObject($response)
    }
    else
    {
        return $null
    }
}
