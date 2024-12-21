function New-NotionPage {
    [CmdletBinding()]
    [OutputType([notion_page])]
    param(
        [Parameter(HelpMessage = "The parent object of the page, if empty it will be created at the root (workspace) level")]
        [object] $parent_obj,
        [Parameter(HelpMessage = "The properties of the page")]
        [hashtable] $properties = @{},
        [Parameter(HelpMessage = "An array of blocks within this page")]
        $children = @(),
        [Parameter(HelpMessage = "The icon of the page")]
        $icon,
        [Parameter(HelpMessage = "The cover image of the page (see notion_file)")]
        $cover,
        [Parameter(HelpMessage = "The title of the page. (Will overwrite the title-property if it exists)")]
        $title
    )
    
    $body = @{}
    
    # if $parent_obj is not provided, add page to Workspace
    $parent_obj ??= [notion_workspace_parent]::new()

    if ($parent_obj -isnot [notion_parent]){
        $parent_obj = [notion_parent]::ConvertFromObject($parent_obj)
    }
    $body.Add("parent", $parent_obj)

    if($properties -and ($properties -isnot [notion_pageproperties])){
        $properties = [notion_pageproperties]::ConvertFromObject($properties)
    }

    if($title -and (-not $properties.Title)){
        $properties.Add("Title",[notion_title_page_property]::new($title))
    }
    elseif ($title -and $properties.Title){
        <# Action when this condition is true #>
        $properties.Title = [notion_title_page_property]::new($title)
    }

    if($properties){
        $body.Add("properties", $propertiesList)
    }

    if($children){
        $childrenList = $children.ForEach({
            if ($_ -is [notion_block])
            {
                $_
            }
            else
            {
                [notion_block]::ConvertFromObject($_)
            }
        })
        $body.Add("children", $childrenList)
    }
    
    if($icon){
        if($icon -isnot [notion_icon]){
            $icon = [notion_icon]::ConvertToObject($icon)
        }
        $body.Add("icon", [notion_icon]::ConvertFromObject($icon))
    }

    if($cover){
        if($cover -isnot [notion_file]){
            $cover = [notion_file]::ConvertToObject($cover)
        }
        $body.Add("cover", [notion_file]::ConvertFromObject($cover))
    }

    try{
        $response = Invoke-NotionAPICall -Method POST -uri "/pages" -Body $body
        return [notion_page]::ConvertFromObject($response)
    }
    catch{
        Write-Error $_.Exception.Message
    }
}
