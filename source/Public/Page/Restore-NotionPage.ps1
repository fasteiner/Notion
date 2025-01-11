function Restore-NotionPage {
    <#
    .SYNOPSIS
    Restores a Notion page by removing it from the trash or archive.

    .DESCRIPTION
    The `Restore-NotionPage` function restores a Notion page by setting the `in_trash` and `archived` properties to `$false`. 
    This function uses the Notion API to perform the restore operation and returns the restored page object.

    .PARAMETER PageId
    The unique identifier of the Notion page to be restored. This parameter is mandatory.

    .OUTPUTS
    [notion_page]
    Returns a `notion_page` object representing the restored Notion page.

    .NOTES
    - The function supports `ShouldProcess` for confirmation and safety.
    - Use this function cautiously, as it interacts with the Notion API to modify page properties.

    .EXAMPLE
    Restore-NotionPage -PageId "12345abcde"

    Restores the Notion page with the ID `12345abcde` by removing it from the trash.

    .EXAMPLE
    Restore-NotionPage -PageId "67890fghij" -WhatIf

    Simulates the restore operation for the Notion page with the ID `67890fghij` without making any changes.

    .EXAMPLE
    Restore-NotionPage -PageId "67890fghij" -Confirm:$false

    Restores the Notion page with the ID `67890fghij` without prompting for confirmation.

    .LINK
    https://developers.notion.com/reference/patch-page
    https://developers.notion.com/reference/archive-a-page#example-request-restore-a-notion-page

    #>
    
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory = $true, Position=0, HelpMessage = "The ID of the page to remove")]
        [Alias("Id")]
        [string]$PageId
    )

    $body = @{
        in_trash = $false
        archived = $false
    }
    $body = $body | Remove-NullValuesFromObject
    if ($PSCmdlet.ShouldProcess($PageId))
    {
        $response = Invoke-NotionApiCall -method PATCH -uri "/pages/$PageId" -body $body
        return [notion_page]::ConvertFromObject($response)
    }
    else
    {
        return $null
    }
}
