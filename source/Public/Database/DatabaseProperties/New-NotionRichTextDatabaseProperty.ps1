function New-NotionRichTextDatabaseProperty
{
    <#
    .SYNOPSIS
        Creates a new Notion rich text database property.

    .DESCRIPTION
        Creates a new instance of notion_rich_text_database_property which represents a rich text type property in a Notion database.

    .EXAMPLE
        PS C:\> New-NotionRichTextDatabaseProperty
        Creates a new rich text database property with default settings.

    .OUTPUTS
        [notion_rich_text_database_property]
    #>
    [CmdletBinding()]
    [OutputType([notion_rich_text_database_property])]
    param ()

    return [notion_rich_text_database_property]::new()
}
