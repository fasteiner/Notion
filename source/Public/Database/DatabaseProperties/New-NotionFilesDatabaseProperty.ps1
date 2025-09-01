function New-NotionFilesDatabaseProperty
{
    <#
    .SYNOPSIS
        Creates a new Notion files database property.

    .DESCRIPTION
        Creates a new instance of notion_files_database_property which represents a files type property in a Notion database.

    .EXAMPLE
        PS C:\> New-NotionFilesDatabaseProperty
        Creates a new files database property with default settings.

    .OUTPUTS
        [notion_files_database_property]
    #>
    [CmdletBinding()]
    [OutputType([notion_files_database_property])]
    param ()

    return [notion_files_database_property]::new()
}
