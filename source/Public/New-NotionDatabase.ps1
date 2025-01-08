function New-NotionDatabase {
    [CmdletBinding()]
    [OutputType([notion_database])]
    param (
        [Parameter(HelpMessage = "The parent object of the page")]
        [object] $parent_obj,
        [Parameter(HelpMessage = "The title(-object) of the database")]
        [object[]] $title,
        [Parameter(Mandatory=$true, HelpMessage = "The properties-objects of the database")]
        [hashtable] $properties
    )
    if($null -eq $parent_obj){
        #TODO: Implement a way to get the default parent
        #$parent = New-NotionPage # (in Workspace)
    }
    else{
        $parent_obj = [notion_parent]::ConvertFromObject($parent_obj)
    }
    $title = $title.foreach({
        if($_ -is [rich_text])
        {
            $_
        }
        else
        {
            if($_ -is [string])
            {
                [rich_text_text]::new($_)
            }
            else
            {
                [rich_text]::ConvertFromObject($_)
            }
        }
    })
    if($properties -isnot [notion_databaseproperties]){
        $properties = [notion_databaseproperties]::ConvertFromObject($properties)
    }

    $body = @{
        parent = $parent_obj
        properties = $properties
    }
    if($title){
        $body.title = $title
    }

    $response = Invoke-NotionAPICall -Method POST -uri "/databases" -Body $body
    return [notion_database]::ConvertFromObject($response)
}
