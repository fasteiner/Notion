function New-NotionFormulaDatabaseProperty
{
    <#
    .SYNOPSIS
        Creates a new Notion formula database property.

    .DESCRIPTION
        Creates a new instance of notion_formula_database_property which represents a formula type property in a Notion database.

    .PARAMETER Expression
        The formula expression to be used in the property.

    .EXAMPLE
        PS C:\> New-NotionFormulaDatabaseProperty
        Creates a new formula database property with default settings.

    .EXAMPLE
        PS C:\> New-NotionFormulaDatabaseProperty -Expression "prop(\"Status\") == \"Done\""
        Creates a new formula database property with the specified formula expression.

    .OUTPUTS
        [notion_formula_database_property]
    #>
    [CmdletBinding()]
    [OutputType([notion_formula_database_property])]
    param (
        [Parameter()]
        [string]$Expression
    )

    if ($PSBoundParameters.ContainsKey('Expression'))
    {
        return [notion_formula_database_property]::new($Expression)
    }
    else
    {
        return [notion_formula_database_property]::new()
    }
}
