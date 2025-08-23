function New-NotionLastEditedByDatabaseProperty
{
    <#
    .SYNOPSIS
        Creates a new Notion last edited by database property.

    .DESCRIPTION
        Creates a new instance of notion_last_edited_by_database_property which represents a last edited by type property in a Notion database.

    .EXAMPLE
        PS C:\> New-NotionLastEditedByDatabaseProperty
        Creates a new last edited by database property with default settings.

    .OUTPUTS
        [notion_last_edited_by_database_property]
    #>
    [CmdletBinding()]
    [OutputType([notion_last_edited_by_database_property])]
    param ()

    return [notion_last_edited_by_database_property]::new()
}
