function New-NotionPeopleDatabaseProperty
{
    <#
    .SYNOPSIS
        Creates a new Notion people database property.

    .DESCRIPTION
        Creates a new instance of notion_people_database_property which represents a people type property in a Notion database.

    .EXAMPLE
        PS C:\> New-NotionPeopleDatabaseProperty
        Creates a new people database property with default settings.

    .OUTPUTS
        [notion_people_database_property]
    #>
    [CmdletBinding()]
    [OutputType([notion_people_database_property])]
    param ()

    return [notion_people_database_property]::new()
}
