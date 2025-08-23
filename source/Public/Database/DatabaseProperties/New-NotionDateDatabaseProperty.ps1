function New-NotionDateDatabaseProperty
{
    <#
    .SYNOPSIS
        Creates a new Notion date database property.

    .DESCRIPTION
        Creates a new instance of notion_date_database_property which represents a date type property in a Notion database.

    .EXAMPLE
        PS C:\> New-NotionDateDatabaseProperty
        Creates a new date database property with default settings.

    .OUTPUTS
        [notion_date_database_property]
    #>
    [CmdletBinding()]
    [OutputType([notion_date_database_property])]
    param ()

    return [notion_date_database_property]::new()
}
