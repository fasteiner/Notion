function Restore-NotionDatabase
{
    <#
    .SYNOPSIS
    Restores a Notion database from the trash.

    .DESCRIPTION
    The `Restore-NotionDatabase` function marks a Notion database as "not in trash" by sending
    a PATCH request to the Notion API. This allows a previously trashed database to become active again.

    .PARAMETER DatabaseId
    The ID of the Notion database to restore. This parameter is mandatory.

    .OUTPUTS
    [notion_database]
    Returns a `notion_database` object representing the restored database.

    .EXAMPLE
    Restore-NotionDatabase -DatabaseId "12345678-abcd-1234-efgh-56789ijklmn0"

    This example restores the database with the specified ID from the trash.

    .NOTES
    Requires the `Invoke-NotionAPICall` function and appropriate API authentication to be configured.
    Ensure you have the necessary permissions to modify the database in Notion.

    .LINK
    https://developers.notion.com/docs
    #>

    [OutputType([notion_database])]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The ID of the database to restore")]
        [Alias("Id")]
        [string]$DatabaseId   
    )

    $body = @{
        in_trash = $false
    }
    $body = $body | Remove-NullValuesFromObject

    $response = Invoke-NotionAPICall -Method PATCH -uri "/databases/$($DatabaseId)" -Body $body
    return [notion_database]::ConvertFromObject($response)
}
