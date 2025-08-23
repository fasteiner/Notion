function New-NotionCreatedByDatabaseProperty 
{
    <#
    .SYNOPSIS
        Creates a new Notion created by database property.

    .DESCRIPTION
        Creates a new instance of notion_created_by_database_property which represents a created by type property in a Notion database.

    .EXAMPLE
        PS C:\> New-NotionCreatedByDatabaseProperty
        Creates a new created by database property with default settings.

    .OUTPUTS
        [notion_created_by_database_property]
    #>
    [CmdletBinding()]    
    [ OutputType( [notion_created_by_database_property]) ]
    param ()

    return [notion_created_by_database_property]::new()
}
