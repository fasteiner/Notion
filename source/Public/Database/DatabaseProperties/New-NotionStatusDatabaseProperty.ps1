function New-NotionStatusDatabaseProperty
{
    <#
    .SYNOPSIS
        Creates a new Notion status database property.

    .DESCRIPTION
        Creates a new instance of notion_status_database_property which represents a status type property in a Notion database.

    .PARAMETER Color
        The color for the initial status option (if Name is provided).

    .PARAMETER Id
        The ID for the initial status option (if Name is provided).

    .PARAMETER Name
        The name of the initial status option to add to the status property.

    .EXAMPLE
        PS C:\> New-NotionStatusDatabaseProperty
        Creates a new status database property with no initial options.

    .EXAMPLE
        PS C:\> New-NotionStatusDatabaseProperty -Name "Not Started"
        Creates a new status database property with one initial status named "Not Started".

    .EXAMPLE
        PS C:\> New-NotionStatusDatabaseProperty -Color "red" -Name "Blocked"
        Creates a new status database property with one red-colored status named "Blocked".

    .EXAMPLE
        PS C:\> New-NotionStatusDatabaseProperty -Color "green" -Id "completed" -Name "Completed"
        Creates a new status database property with a green status having specific ID and name.

    .OUTPUTS
        [notion_status_database_property]
    #>
    [CmdletBinding()]
    [OutputType([notion_status_database_property])]
    param (
        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [notion_color]$Color = [notion_color]::default,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [string]$Id,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [string]$Name
    )
    process
    {
        if ($PSBoundParameters.ContainsKey('Name'))
        {
            if ($PSBoundParameters.ContainsKey('Id'))
            {
                return [notion_status_database_property]::new($Color, $Id, $Name)
            }
            elseif ($PSBoundParameters.ContainsKey('Color'))
            {
                return [notion_status_database_property]::new($Color, $Name)
            }
            # Can't happen due to default value
            # else
            # {
            #     return [notion_status_database_property]::new($Name)
            # }
        }
        else
        {
            return [notion_status_database_property]::new()
        }
    }
}
