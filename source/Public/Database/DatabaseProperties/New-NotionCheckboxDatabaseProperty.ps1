function New-NotionCheckboxDatabaseProperty 
{
    <#
    .SYNOPSIS
        Creates a new Notion checkbox database property.

    .DESCRIPTION
        Creates a new instance of notion_checkbox_database_property which represents a checkbox type property in a Notion database.

    .EXAMPLE
        PS C:\> New-NotionCheckboxDatabaseProperty
        Creates a new checkbox database property with default settings.

    .OUTPUTS
        [notion_checkbox_database_property]
    #>
    [CmdletBinding()]
    [OutputType([notion_checkbox_database_property])]
    param ()

    return [notion_checkbox_database_property]::new()
}
