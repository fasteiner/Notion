function New-NotionUrlDatabaseProperty
{
    <#
    .SYNOPSIS
        Creates a new Notion URL database property.

    .DESCRIPTION
        Creates a new instance of notion_url_database_property which represents a URL type property in a Notion database.

    .EXAMPLE
        PS C:\> New-NotionUrlDatabaseProperty
        Creates a new URL database property with default settings.

    .OUTPUTS
        [notion_url_database_property]
    #>
    [CmdletBinding()]
    [OutputType([notion_url_database_property])]
    param ()

    return [notion_url_database_property]::new()
}
