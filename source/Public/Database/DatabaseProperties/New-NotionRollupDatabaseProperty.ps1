function New-NotionRollupDatabaseProperty
{
    <#
    .SYNOPSIS
        Creates a new Notion rollup database property.

    .DESCRIPTION
        Creates a new instance of notion_rollup_database_property which represents a rollup type property in a Notion database.

    .PARAMETER RelationPropertyName
        The name of the relation property to rollup from.

    .PARAMETER RollupPropertyName
        The name of the property to rollup.

    .PARAMETER Function
        The rollup function to apply (count, count_values, empty, not_empty, unique, show_unique, percent_empty, etc.).

    .EXAMPLE
        PS C:\> New-NotionRollupDatabaseProperty
        Creates a new rollup database property with default settings.

    .EXAMPLE
        PS C:\> New-NotionRollupDatabaseProperty -RelationPropertyName "Tasks" -RollupPropertyName "Status" -Function "count"
        Creates a new rollup database property that counts the Status values from the Tasks relation.

    .OUTPUTS
        [notion_rollup_database_property]
    #>
    [CmdletBinding()]
    [OutputType([notion_rollup_database_property])]
    param (
        [Parameter()]
        [string]$RelationPropertyName,

        [Parameter()]
        [string]$RollupPropertyName,

        [Parameter()]
        [string]$Function
    )

    if ($PSBoundParameters.ContainsKey('RelationPropertyName') -and 
        $PSBoundParameters.ContainsKey('RollupPropertyName') -and 
        $PSBoundParameters.ContainsKey('Function'))
    {
        return [notion_rollup_database_property]::new($RelationPropertyName, $RollupPropertyName, $Function)
    }
    else
    {
        if ($PSBoundParameters.Count -ne 0)
        {
            Write-Warning "Some parameters were provided but not all required parameters are present. Returning default rollup property."
        }
        return [notion_rollup_database_property]::new()
    }
}
