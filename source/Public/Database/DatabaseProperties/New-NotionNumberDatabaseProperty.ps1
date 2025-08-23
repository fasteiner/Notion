function New-NotionNumberDatabaseProperty
{
    <#
    .SYNOPSIS
        Creates a new Notion number database property.

    .DESCRIPTION
        Creates a new instance of notion_number_database_property which represents a number type property in a Notion database.

    .PARAMETER Format
        The format type for the number property (number, euro, percent, etc.).

    .EXAMPLE
        PS C:\> New-NotionNumberDatabaseProperty
        Creates a new number database property with default format.

    .EXAMPLE
        PS C:\> New-NotionNumberDatabaseProperty -Format "euro"
        Creates a new number database property with euro format.

    .OUTPUTS
        [notion_number_database_property]
    #>
    [CmdletBinding()]
    [OutputType([notion_number_database_property])]
    param (
        [Parameter(Position = 0)]
        [notion_database_property_format_type]$Format
    )

    if ($PSBoundParameters.ContainsKey('Format'))
    {
        return [notion_number_database_property]::new($Format)
    }
    else
    {
        return [notion_number_database_property]::new()
    }
}
