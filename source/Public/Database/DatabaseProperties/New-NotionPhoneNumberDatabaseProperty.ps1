function New-NotionPhoneNumberDatabaseProperty
{
    <#
    .SYNOPSIS
        Creates a new Notion phone number database property.

    .DESCRIPTION
        Creates a new instance of notion_phone_number_database_property which represents a phone number type property in a Notion database.

    .EXAMPLE
        PS C:\> New-NotionPhoneNumberDatabaseProperty
        Creates a new phone number database property with default settings.

    .OUTPUTS
        [notion_phone_number_database_property]
    #>
    [CmdletBinding()]
    [OutputType([notion_phone_number_database_property])]
    param ()

    return [notion_phone_number_database_property]::new()
}
