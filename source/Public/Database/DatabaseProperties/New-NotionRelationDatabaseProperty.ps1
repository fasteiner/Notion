function New-NotionRelationDatabaseProperty 
{
    <#
    .SYNOPSIS
        Creates a new Notion relation database property.

    .DESCRIPTION
        Creates a new instance of notion_relation_database_property which represents a relation type property in a Notion database.

    .PARAMETER DatabaseId
        The ID of the related database.

    .PARAMETER RelationType
        The type of relation (single_property or dual_property).

    .PARAMETER SyncedPropertyId
        The ID of the synced property.

    .PARAMETER SyncedPropertyName
        The name of the synced property.

    .EXAMPLE
        PS C:\> New-NotionRelationDatabaseProperty -DatabaseId "123456" -RelationType single_property -SyncedPropertyId "prop_id" -SyncedPropertyName "Tasks"
        Creates a new relation database property linking to the specified database with the given synced property details.

    .EXAMPLE
        PS C:\> New-NotionRelationDatabaseProperty -DatabaseId "123456" -RelationType dual_property -SyncedPropertyId "prop_id" -SyncedPropertyName "Related Projects"
        Creates a new dual relation database property pointing to the specified database with the given synced property details.

    .OUTPUTS
        [notion_relation_database_property]
    #>
    [CmdletBinding()]
    [OutputType([notion_relation_database_property])]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [Alias("ID")]
        [string]$DatabaseId,

        [Parameter(Mandatory = $true)]
        [ValidateSet("single_property", "dual_property")]
        [notion_database_relation_type]$RelationType,

        [Parameter(Mandatory = $true)]
        [string]$SyncedPropertyId,

        [Parameter(Mandatory = $true)]
        [string]$SyncedPropertyName
    )

    # Create a new relation database property with all required parameters
    return [notion_relation_database_property]::new($DatabaseId, $RelationType, $SyncedPropertyId, $SyncedPropertyName)
}
