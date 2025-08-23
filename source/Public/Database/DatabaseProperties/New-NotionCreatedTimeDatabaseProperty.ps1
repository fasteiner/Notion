function New-NotionCreatedTimeDatabaseProperty
{
    <#
    .SYNOPSIS
        Creates a new Notion created time database property.

    .DESCRIPTION
        Creates a new instance of notion_created_time_database_property which represents a created time type property in a Notion database.

    .EXAMPLE
        PS C:\> New-NotionCreatedTimeDatabaseProperty
        Creates a new created time database property with default settings.

    .OUTPUTS
        [notion_created_time_database_property]
    #>
    [CmdletBinding()]
    [OutputType([notion_created_time_database_property])]
    param ()

    return [notion_created_time_database_property]::new()
}
