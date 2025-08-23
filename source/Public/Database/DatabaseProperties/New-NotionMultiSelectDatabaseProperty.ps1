function New-NotionMultiSelectDatabaseProperty
{
    <#
    .SYNOPSIS
        Creates a new Notion multi-select database property.

    .DESCRIPTION
        Creates a new instance of notion_multi_select_database_property which represents a multi-select type property in a Notion database.

    .PARAMETER Color
        The color for the initial option (if Name is provided).

    .PARAMETER Name
        The name of the initial option to add to the multi-select property.

    .EXAMPLE
        PS C:\> New-NotionMultiSelectDatabaseProperty
        Creates a new multi-select database property with no initial options.

    .EXAMPLE
        PS C:\> New-NotionMultiSelectDatabaseProperty -Name "Option 1"
        Creates a new multi-select database property with one initial option named "Option 1".

    .EXAMPLE
        PS C:\> New-NotionMultiSelectDatabaseProperty -Color "blue" -Name "Priority"
        Creates a new multi-select database property with one blue-colored option named "Priority".

    .OUTPUTS
        [notion_multi_select_database_property]
    #>
    [CmdletBinding()]
    [OutputType([notion_multi_select_database_property])]
    param (
        [Parameter(ValueFromPipelineByPropertyName=$true)]
        $Color = [notion_property_color]::default,

        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string]$Name
    )
    begin{
        $multiSelectProperty = [notion_multi_select_database_property]::new()
    }
    process{
        $multiSelectProperty.add($Name, $Color)
    }
    end{
        return $multiSelectProperty
    }
}
