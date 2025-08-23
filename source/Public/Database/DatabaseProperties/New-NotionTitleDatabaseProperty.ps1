function New-NotionTitleDatabaseProperty
{
    <#
    .SYNOPSIS
        Creates a new Notion title database property.

    .DESCRIPTION
        Creates a new instance of notion_title_database_property which represents a title type property in a Notion database.

    .EXAMPLE
        PS C:\> New-NotionTitleDatabaseProperty
        Creates a new title database property with default settings.

    .OUTPUTS
        [notion_title_database_property]
    #>
    [CmdletBinding()]
    [OutputType([notion_title_database_property])]
    param ()

    return [notion_title_database_property]::new()
}
