function New-NotionSelectDatabaseProperty
{
    <#
    .SYNOPSIS
        Creates a new Notion select database property.

    .DESCRIPTION
        Creates a new instance of notion_select_database_property which represents a select type property in a Notion database.

    .PARAMETER Color
        The color for the initial option (if Name is provided).

    .PARAMETER Id
        The ID for the initial option (if Name is provided).

    .PARAMETER Name
        The name of the initial option to add to the select property.

    .EXAMPLE
        PS C:\> New-NotionSelectDatabaseProperty
        Creates a new select database property with no initial options.

    .EXAMPLE
        PS C:\> New-NotionSelectDatabaseProperty -Name "Option 1"
        Creates a new select database property with one initial option named "Option 1".

    .EXAMPLE
        PS C:\> New-NotionSelectDatabaseProperty -Color "blue" -Name "Priority"
        Creates a new select database property with one blue-colored option named "Priority".

    .EXAMPLE
        PS C:\> New-NotionSelectDatabaseProperty -Color "red" -Id "high-priority" -Name "High Priority"
        Creates a new select database property with a red option having specific ID and name.

    .OUTPUTS
        [notion_select_database_property]
    #>
    [CmdletBinding()]
    [OutputType([notion_select_database_property])]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [notion_color]$Color = [notion_color]::default,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [string]$Id,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [string]$Name
    )
    process{
        if ($PSBoundParameters.ContainsKey('Name'))
        {
            if ($PSBoundParameters.ContainsKey('Id'))
            {
                return [notion_select_database_property]::new($Color, $Id, $Name)
            }
            elseif ($PSBoundParameters.ContainsKey('Color'))
            {
                return [notion_select_database_property]::new($Color, $Name)
            }
            # Can't happen because Color has a default value
            # else
            # {
            #     return [notion_select_database_property]::new($Name)
            # }
        }
        else
        {
            return [notion_select_database_property]::new()
        }
    }
}
