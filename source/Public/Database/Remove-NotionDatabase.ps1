function Remove-NotionDatabase
{
    <#
    .SYNOPSIS
    Moves a Notion database to the trash.

    .DESCRIPTION
    The `Remove-NotionDatabase` function marks a Notion database as "in trash" by sending
    a PATCH request to the Notion API. This effectively removes the database from active use.

    .PARAMETER DatabaseId
    The ID of the Notion database to move to the trash. This parameter is mandatory.

    .PARAMETER Confirm
    Prompts the user for confirmation before moving the database to the trash. The default is $true.

    .OUTPUTS
    [notion_database] | $null
    Returns a `notion_database` object representing the trashed database. Returns $null if the operation is cancelled.

    .EXAMPLE
    Remove-NotionDatabase -DatabaseId "12345678-abcd-1234-efgh-56789ijklmn0" -Confirm:$false

    This example moves the database with the specified ID to the trash.

    .NOTES
    Requires the `Invoke-NotionAPICall` function and appropriate API authentication to be configured.
    This function does not permanently delete the database but marks it as "in trash."
    Ensure you have appropriate permissions to modify the database in Notion.

    .LINK
    https://developers.notion.com/reference/database (in_trash = true)
    https://developers.notion.com/reference/update-a-database
    #>

    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType([notion_database])]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The ID of the database to remove")]
        [Alias("Id")]
        [string]$DatabaseId
    )

    $body = @{
        in_trash = $true
    }
    $body = $body | Remove-NullValuesFromObject
    if ($PSCmdlet.ShouldProcess("Database $DatabaseId", "Move to trash"))
    { 
        $response = Invoke-NotionAPICall -Method PATCH -uri "/databases/$($DatabaseId)" -Body $body
        return [notion_database]::ConvertFromObject($response)
    }
    else
    {
        return $null
    }

}
