function Add-NotionDatabaseProperty 
{
    <#
    .SYNOPSIS
    Adds a new property to a Notion database.

    .DESCRIPTION
    The `Add-NotionDatabaseProperty` function adds a specified property to a Notion database using the Notion API. 
    You can specify the database ID, the property object, and the name of the property to be added. 
    The function supports pipeline input for adding multiple properties in a single invocation.

    .PARAMETER DatabaseId
    The unique identifier of the Notion database where the property will be added. This parameter is mandatory.

    .PARAMETER property
    The property object to be added to the database. This parameter is mandatory and accepts input via the pipeline by property name.

    .PARAMETER PropertyName
    The name of the property to be added to the database. This parameter is mandatory and accepts input via the pipeline by property name.

    .OUTPUTS
    [notion_database]
    Returns a `notion_database` object representing the updated Notion database.

    .EXAMPLE
    
    Add-NotionDatabaseProperty -DatabaseId "12345abcde" -property @{ type = "title"; title = @{ text = @{ content = "New Title" } } } -PropertyName "Title"
    

    Adds a new title property named "Title" to the database with the ID `12345abcde`.

    .EXAMPLE
    
    @(
        @{ property = @{ type = "number"; number = @{ format = "number" } }; PropertyName = "Score" },
        @{ property = @{ type = "select"; select = @{ options = @(@{ name = "Option 1" }, @{ name = "Option 2" }) } }; PropertyName = "Category" }
    ) | Add-NotionDatabaseProperty -DatabaseId "12345abcde"
    

    Adds multiple properties (`Score` and `Category`) to the database with the ID `12345abcde` using pipeline input.

    .EXAMPLE
    
    $input = @{
        DatabaseId = "12345abcde"
        property = @{ type = "number"; number = @{ format = "number" } }
        PropertyName = "Score"
    }
    Add-NotionDatabaseProperty @input
    

    Adds a new number property named "Score" to the database with the ID `12345abcde`.

    .LINK
    https://developers.notion.com/reference/update-property-schema-object
    #>  
    [CmdletBinding()]
    [OutputType([notion_database])]
    param (
        [Parameter(Mandatory= $true, Position = 0,HelpMessage = "The ID of the database to add the property to")]
        [Alias("Id")]
        [string]$DatabaseId,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName=$true, HelpMessage = "The property object to add to the database")]
        [object]$property,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName=$true, HelpMessage = "The name of the property to add to the database")]
        [string]$PropertyName

    )
    begin{
        $properties = [notion_databaseproperties]::new()
    }
    process{
        $properties = $properties.AddProperty($property, $PropertyName)
    }
    end{
        $body = @{
            properties = $properties
        }
        $response = Invoke-NotionApiCall -method PATCH -uri "/databases/$DatabaseId" -body $body
        return [notion_database]::ConvertFromObject($response)
    }
    
}
