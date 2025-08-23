function New-NotionLastEditedTimeDatabaseProperty
{
    <#
    .SYNOPSIS
        Creates a new Notion last edited time database property.

    .DESCRIPTION
        Creates a new instance of notion_last_edited_time_database_property which represents a last edited time type property in a Notion database.

    .EXAMPLE
        PS C:\> New-NotionLastEditedTimeDatabaseProperty
        Creates a new last edited time database property with default settings.

    .OUTPUTS
        [notion_last_edited_time_database_property]
    #>
    [CmdletBinding()]
    [OutputType([notion_last_edited_time_database_property])]
    param ()

    return [notion_last_edited_time_database_property]::new()
}
