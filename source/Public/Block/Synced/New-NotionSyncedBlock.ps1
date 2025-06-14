function New-NotionSyncedBlock
{
    <#
    .SYNOPSIS
        Creates a new Notion synced block object.

    .DESCRIPTION
        This function creates a new instance of the notion_synced_block class.
        You can create an empty synced block.

    .EXAMPLE
        New-NotionSyncedBlock

    .OUTPUTS
        notion_synced_block
    #>
    [CmdletBinding()]
    param ()

    $obj = [notion_synced_block]::new()
    return $obj
}
