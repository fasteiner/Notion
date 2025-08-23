function New-NotionDatabaseProperty
{
    <#
    .SYNOPSIS
        Creates a new Notion database property of the specified type.

    .DESCRIPTION
        Creates a new instance of a Notion database property based on the specified type and parameters.
        This function serves as a central factory for creating various types of database properties.

    .PARAMETER Type
        The type of database property to create (checkbox, text, number, select, multi_select, date, people, files, url, email, phone_number, formula, relation, rollup, created_time, created_by, last_edited_time, last_edited_by, title, rich_text, status, unique_id, verification).

    .PARAMETER Name
        The name for select/multi_select/status options or rollup property name.

    .PARAMETER Color
        The color for select/multi_select/status options.

    .PARAMETER Id
        The ID for select/status options or database ID for relations.

    .PARAMETER Expression
        The formula expression for formula properties.

    .PARAMETER Format
        The format type for number properties.

    .PARAMETER DatabaseId
        The ID of the related database for relation properties.

    .PARAMETER RelationType
        The type of relation (single_property or dual_property) for relation properties.

    .PARAMETER SyncedPropertyId
        The ID of the synced property for relation properties.

    .PARAMETER SyncedPropertyName
        The name of the synced property for relation properties.

    .PARAMETER RelationPropertyName
        The name of the relation property for rollup properties.

    .PARAMETER RollupPropertyName
        The name of the property to rollup for rollup properties.

    .PARAMETER Function
        The rollup function to apply for rollup properties.

    .PARAMETER Prefix
        The prefix for unique_id properties.

    .EXAMPLE
        PS C:\> New-NotionDatabaseProperty -Type checkbox
        Creates a new checkbox database property.

    .EXAMPLE
        PS C:\> New-NotionDatabaseProperty -Type select -Name "Priority" -Color "red"
        Creates a new select database property with a red "Priority" option.

    .EXAMPLE
        PS C:\> New-NotionDatabaseProperty -Type formula -Expression "prop(\"Status\") == \"Done\""
        Creates a new formula database property with the specified expression.

    .EXAMPLE
        PS C:\> New-NotionDatabaseProperty -Type number -Format "euro"
        Creates a new number database property with euro format.

    .EXAMPLE
        PS C:\> New-NotionDatabaseProperty -Type unique_id -Prefix "TASK-"
        Creates a new unique ID database property with "TASK-" prefix.

    .OUTPUTS
        [DatabasePropertiesBase] - Returns the appropriate database property type based on the Type parameter.
    #>
    [CmdletBinding()]
    [OutputType([DatabasePropertiesBase])]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [notion_database_property_type]$Type,

        [Parameter()]
        [string]$Name,

        [Parameter()]
        [notion_color]$Color = [notion_color]::default,

        [Parameter()]
        [string]$Id,

        [Parameter()]
        [string]$Expression,

        [Parameter()]
        [notion_database_property_format_type]$Format,

        [Parameter()]
        [string]$DatabaseId,

        [Parameter()]
        [ValidateSet("single_property", "dual_property")]
        [notion_database_relation_type]$RelationType,

        [Parameter()]
        [string]$SyncedPropertyId,

        [Parameter()]
        [string]$SyncedPropertyName,

        [Parameter()]
        [string]$RelationPropertyName,

        [Parameter()]
        [string]$RollupPropertyName,

        [Parameter()]
        [string]$Function,

        [Parameter()]
        [string]$Prefix
    )

    switch ($Type)
    {
        'checkbox'
        {
            return New-NotionCheckboxDatabaseProperty
        }
        'text'
        {
            return New-NotionRichTextDatabaseProperty
        }
        'rich_text'
        {
            return New-NotionRichTextDatabaseProperty
        }
        'number'
        {
            if ($PSBoundParameters.ContainsKey('Format'))
            {
                return New-NotionNumberDatabaseProperty -Format $Format
            }
            else
            {
                return New-NotionNumberDatabaseProperty
            }
        }
        'select'
        {
            $selectParams = @{}
            if ($PSBoundParameters.ContainsKey('Color'))
            {
                $selectParams['Color'] = $Color 
            }
            if ($PSBoundParameters.ContainsKey('Id'))
            {
                $selectParams['Id'] = $Id 
            }
            if ($PSBoundParameters.ContainsKey('Name'))
            {
                $selectParams['Name'] = $Name 
            }
            return New-NotionSelectDatabaseProperty @selectParams
        }
        'multi_select'
        {
            if ($PSBoundParameters.ContainsKey('Name'))
            {
                $multiSelectParams = @{}
                if ($PSBoundParameters.ContainsKey('Color'))
                {
                    $multiSelectParams['Color'] = $Color 
                }
                $multiSelectParams['Name'] = $Name
                return New-NotionMultiSelectDatabaseProperty @multiSelectParams
            }
            else
            {
                return New-NotionMultiSelectDatabaseProperty
            }
        }
        'status'
        {
            $statusParams = @{}
            if ($PSBoundParameters.ContainsKey('Color'))
            {
                $statusParams['Color'] = $Color 
            }
            if ($PSBoundParameters.ContainsKey('Id'))
            {
                $statusParams['Id'] = $Id 
            }
            if ($PSBoundParameters.ContainsKey('Name'))
            {
                $statusParams['Name'] = $Name 
            }
            return New-NotionStatusDatabaseProperty @statusParams
        }
        'date'
        {
            return New-NotionDateDatabaseProperty
        }
        'people'
        {
            return New-NotionPeopleDatabaseProperty
        }
        'files'
        {
            return New-NotionFilesDatabaseProperty
        }
        'url'
        {
            return New-NotionUrlDatabaseProperty
        }
        'email'
        {
            return New-NotionEmailDatabaseProperty
        }
        'phone_number'
        {
            return New-NotionPhoneNumberDatabaseProperty
        }
        'formula'
        {
            if ($PSBoundParameters.ContainsKey('Expression'))
            {
                return New-NotionFormulaDatabaseProperty -Expression $Expression
            }
            else
            {
                return New-NotionFormulaDatabaseProperty
            }
        }
        'relation'
        {
            if ($PSBoundParameters.ContainsKey('DatabaseId') -and 
                $PSBoundParameters.ContainsKey('RelationType') -and 
                $PSBoundParameters.ContainsKey('SyncedPropertyId') -and 
                $PSBoundParameters.ContainsKey('SyncedPropertyName'))
            {
                return New-NotionRelationDatabaseProperty -DatabaseId $DatabaseId -RelationType $RelationType -SyncedPropertyId $SyncedPropertyId -SyncedPropertyName $SyncedPropertyName
            }
            else
            {
                throw "Relation properties require DatabaseId, RelationType, SyncedPropertyId, and SyncedPropertyName parameters."
            }
        }
        'rollup'
        {
            if ($PSBoundParameters.ContainsKey('RelationPropertyName') -and 
                $PSBoundParameters.ContainsKey('RollupPropertyName') -and 
                $PSBoundParameters.ContainsKey('Function'))
            {
                return New-NotionRollupDatabaseProperty -RelationPropertyName $RelationPropertyName -RollupPropertyName $RollupPropertyName -Function $Function
            }
            else
            {
                return New-NotionRollupDatabaseProperty
            }
        }
        'created_time'
        {
            return New-NotionCreatedTimeDatabaseProperty
        }
        'created_by'
        {
            return New-NotionCreatedByDatabaseProperty
        }
        'last_edited_time'
        {
            return New-NotionLastEditedTimeDatabaseProperty
        }
        'last_edited_by'
        {
            return New-NotionLastEditedByDatabaseProperty
        }
        'title'
        {
            return New-NotionTitleDatabaseProperty
        }
        'unique_id'
        {
            if ($PSBoundParameters.ContainsKey('Prefix'))
            {
                return New-NotionUniqueIdDatabaseProperty -Prefix $Prefix
            }
            else
            {
                return New-NotionUniqueIdDatabaseProperty
            }
        }
        'verification'
        {
            return New-NotionVerificationDatabaseProperty
        }
        default
        {
            throw "Unknown database property type: $Type"
        }
    }
}
