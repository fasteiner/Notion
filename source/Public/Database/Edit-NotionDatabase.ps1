function Edit-NotionDatabase
{
    <#
    .SYNOPSIS
        Edit the properties, title, and description of an existing Notion database.
    
    .DESCRIPTION
        The Edit-NotionDatabase function allows you to edit the properties, title, and description of an existing Notion database.
    
    .PARAMETER DatabaseId
        The ID of the Notion database to be edited.
    
    .PARAMETER title
        An array of objects / a single object or string representing the title of the database. Each object can be a string or a rich_text object.
    
    .PARAMETER properties
        A hashtable representing the properties of the database. Use null values to remove properties.
    
    .PARAMETER description
        An array of objects / a single object or string representing the description of the database. Each object can be a string or a rich_text object.
    
    .OUTPUTS
        [notion_database]
        Returns the updated Notion database object.
    
    .EXAMPLE
        $title = "New Database Title"
        $properties = @{
            "Property1" = @{
                "name" = "New Property Name"
                "type" = "text"
            }
            "PropertyToRemove" = $null
        }
        $description = "This is a new description for the database."
        Edit-NotionDatabase -DatabaseId "your-database-id" -title $title -properties $properties -description $description

        This command overwrites the title and description and edits the properties of the specified Notion database.

    .EXAMPLE
        $database = Get-NotionDatabase -DatabaseId "your-database-id"
        $db_properties = $database.properties
        $db_properties.PropertyToRemove = $null
        Edit-NotionDatabase -DatabaseId "your-database-id" -properties $db_properties

        This command removes the "PropertyToRemove" property from the specified Notion database.
    
    .NOTES
        This function requires the Invoke-NotionAPICall function to make API calls to Notion.

    .LINK
        https://developers.notion.com/reference/patch-database
    #>
    [CmdletBinding()]
    [OutputType([notion_database])]
    param (
        [Alias("Id")]
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$DatabaseId,
        [object[]] $title,
        [Parameter( HelpMessage = "The properties-objects of the database; value null for removing properties" )]
        [hashtable] $properties,
        [object[]] $description
    )
    $title = $title.foreach({
            if ($_ -is [rich_text])
            {
                $_
            }
            else
            {
                if ($_ -is [string])
                {
                    [rich_text_text]::new($_)
                }
                else
                {
                    [rich_text]::ConvertFromObject($_)
                }
            }
        })

    $description = $description.foreach({
            if ($_ -is [rich_text])
            {
                $_
            }
            else
            {
                if ($_ -is [string])
                {
                    [rich_text_text]::new($_)
                }
                else
                {
                    [rich_text]::ConvertFromObject($_)
                }
            }
        })
    if ($properties -isnot [notion_databaseproperties])
    {
        $properties = [notion_databaseproperties]::ConvertFromObject($properties)
    }

    $body = @{
    }
    if ($title)
    {
        $body.title = @($title | Remove-NullValuesFromObject)
    }
    if ($description)
    {
        $body.description = @($description | Remove-NullValuesFromObject)

    }
    if ($properties)
    {
        # here null values are not removed, because they are needed to remove properties
        $body.properties = $properties
    }

    $response = Invoke-NotionAPICall -Method PATCH -uri "/databases/$DatabaseId" -Body $body
    return [notion_database]::ConvertFromObject($response)
}
