function New-NotionDatabase
{
    <#
    .SYNOPSIS
    Creates a new Notion database.

    .DESCRIPTION
    The New-NotionDatabase function creates a new Notion database within the specified parent object, title, and properties. 
    It converts the provided parameters to the appropriate types and makes an API call to create the database in Notion.

    .PARAMETER parent_obj
    The parent object of the page. If not provided, a default parent will be used.

    .PARAMETER title
    The title (or title object) of the database. Can be a string or an array of rich text objects.

    .PARAMETER properties
    The properties objects of the database. This parameter is mandatory.

    .OUTPUTS
    [notion_database]
    Returns a notion_database object representing the newly created database.

    .EXAMPLE
    $parent = @{
        type    = "page_id"
        page_id = "12345678901234567890"
    }
    $title = "My New Database"
    $properties = @{
        Name = @{
            type = "title"
            title = @{}
        }
    }
    New-NotionDatabase -parent_obj $parent -title $title -properties $properties

    This command creates a new Notion database within the specified parent page, title, and properties.

    .NOTES
    This function requires the Invoke-NotionAPICall and Remove-NullValuesFromObject helper functions, 
    as well as the notion_database, notion_parent, rich_text, rich_text_text, and notion_databaseproperties types.

    .LINK
    https://developers.notion.com/reference/create-a-database
    #>

    [CmdletBinding()]
    [OutputType([notion_database])]
    param (
        [Parameter(HelpMessage = "The parent object of the page")]
        [object] $parent_obj,
        [Parameter(HelpMessage = "The title(-object) of the database")]
        [object[]] $title,
        [Parameter(Mandatory = $true, HelpMessage = "The properties-objects of the database")]
        [hashtable] $properties
    )
    if ($null -eq $parent_obj)
    {
        #TODO: Implement a way to get the default parent
        #$parent = New-NotionPage # (in Workspace)
        throw "Parent object is required"
    }
    else
    {
        $parent_obj = [notion_parent]::ConvertFromObject($parent_obj)
    }
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
    if ($properties -isnot [notion_databaseproperties])
    {
        $properties = [notion_databaseproperties]::ConvertFromObject($properties)
    }

    $body = @{
        parent     = $parent_obj
        properties = $properties
    }
    if ($title)
    {
        $body.title = $title
    }
    $body = $body | Remove-NullValuesFromObject
    $response = Invoke-NotionAPICall -Method POST -uri "/databases" -Body $body
    return [notion_database]::ConvertFromObject($response)
}
