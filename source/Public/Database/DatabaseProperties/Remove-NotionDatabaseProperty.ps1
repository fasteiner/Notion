function Remove-NotionDatabaseProperty {
    <#
    .SYNOPSIS
    Removes a specified property from a Notion database.
    
    .DESCRIPTION
    The Remove-NotionDatabaseProperty function removes a property from a Notion database by setting the property to null. 
    It uses the Notion API to update the database.
    
    .PARAMETER DatabaseId
    The ID of the Notion database from which the property will be removed.
    
    .PARAMETER Property
    The ID or name of the property to remove from the Notion database.
    
    .EXAMPLE
    Remove-NotionDatabaseProperty -DatabaseId "12345678-1234-1234-1234-1234567890ab" -Property "PropertyName"
    
    This example removes the property named "PropertyName" from the specified Notion database.
    
    .EXAMPLE
    (Get-NotionDatabase -DatabaseId "12345678-1234-1234-1234-1234567890ab").Properties.Values.Name | Remove-NotionDatabaseProperty -DatabaseId "12345678-1234-1234-1234-1234567890ab"
    
    This example removes *all* properties by name from the specified Notion database using the pipeline. (Use with care!)
    
    .EXAMPLE
    (Get-NotionDatabase -DatabaseId "12345678-1234-1234-1234-1234567890ab").Properties.Values.Id | Remove-NotionDatabaseProperty -DatabaseId "12345678-1234-1234-1234-1234567890ab"
    
    This example removes *all* properties by Id from the specified Notion database using the pipeline. (Use with care!)
    
    .EXAMPLE
    @("PropertyName1", "PropertyName2") | Remove-NotionDatabaseProperty -DatabaseId "12345678-1234-1234-1234-1234567890ab"
    
    This example removes multiple properties from the specified Notion database using the pipeline.
    
    .LINK
    https://developers.notion.com/reference/update-property-schema-object
    
    #>

    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType([notion_database])]
    param (
        [Parameter(Mandatory = $true, Position = 0, HelpMessage = "The ID of the database to remove the property from")]
        [alias("Id")]
        [string]$DatabaseId,
        
        [Parameter(ValueFromPipeline = $true,Mandatory = $true, HelpMessage = "The id or name of the property to remove")]
        [string]$Property
    )

    begin{
        $properties = [notion_databaseproperties]::new()
    }
    process{
        $properties.Add("$Property", $null)
    }
    end{
        $body = @{
            properties = $properties
        }
    
        $response = Invoke-NotionApiCall -method PATCH -uri "/databases/$DatabaseId" -body $body
        return [notion_database]::ConvertFromObject($response)
    }
}
