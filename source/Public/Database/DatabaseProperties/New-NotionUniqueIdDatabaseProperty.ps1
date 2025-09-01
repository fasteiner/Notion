function New-NotionUniqueIdDatabaseProperty
{
    <#
    .SYNOPSIS
        Creates a new Notion unique ID database property.

    .DESCRIPTION
        Creates a new instance of notion_unique_id_database_property which represents a unique ID type property in a Notion database.

    .PARAMETER Prefix
        The prefix to use for the unique ID.

    .EXAMPLE
        PS C:\> New-NotionUniqueIdDatabaseProperty
        Creates a new unique ID database property with default settings.

    .EXAMPLE
        PS C:\> New-NotionUniqueIdDatabaseProperty -Prefix "TASK-"
        Creates a new unique ID database property with the prefix "TASK-".

    .OUTPUTS
        [notion_unique_id_database_property]
    #>
    [CmdletBinding()]
    [OutputType([notion_unique_id_database_property])]
    param (
        [Parameter(Position = 0, ValueFromPipelineByPropertyName = $true, ValueFromPipeline = $true)]
        [string]$Prefix
    )
    process
    {
        if ($prefix)
        {
            return [notion_unique_id_database_property]::new($Prefix)
        }
        else
        {
            return [notion_unique_id_database_property]::new()
        }
    }
}
