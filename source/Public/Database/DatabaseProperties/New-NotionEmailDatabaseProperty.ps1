function New-NotionEmailDatabaseProperty
{
    <#
    .SYNOPSIS
        Creates a new Notion email database property.

    .DESCRIPTION
        Creates a new instance of notion_email_database_property which represents an email type property in a Notion database.

    .EXAMPLE
        PS C:\> New-NotionEmailDatabaseProperty
        Creates a new email database property with default settings.

    .OUTPUTS
        [notion_email_database_property]
    #>
    [CmdletBinding()]
    [OutputType([notion_email_database_property])]
    param ()

    return [notion_email_database_property]::new()
}
