function New-NotionPage
{
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
    try
    {
        $body = @{}
    
        # if $parent_obj is not provided, add page to Workspace
        $parent_obj ??= [notion_workspace_parent]::new()

        if ($parent_obj -isnot [notion_parent])
        {
            $parent_obj = [notion_parent]::ConvertFromObject($parent_obj)
        }
        $body.Add("parent", $parent_obj)

        if (($parent.Type -eq "page_id") -and ($properties -gt 0))
        {
            Write-Warning "the new page is a child of an existing page, title is the only valid property!"
            $properties = @{}
        }

        if (($properties.count -gt 0) -and ($properties -isnot [notion_pageproperties]))
        {
            $properties = [notion_pageproperties]::ConvertFromObject($properties)
        }

        if ($title -and (-not $properties.Title))
        {
            #BUG: [notion_title_page_property]::new($title) geht so nicht
            $titleobj = [rich_text]::new([rich_text_type]::text, [annotation]::new())
            $titleobj.plain_text = $title
            #$properties.Add("Title", [notion_title_page_property]::new($title))
            $properties.Add("Title", $titleobj)
        }
        elseif ($title -and $properties.Title)
        {
            <# Action when this condition is true #>
            $properties.Title = [notion_title_page_property]::new($title)
        }
        $body.Add("properties", $properties)

        if ($children)
        {
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
    
        if ($icon)
        {
            if ($icon -isnot [notion_icon])
            {
                $icon = [notion_icon]::ConvertToObject($icon)
            }
            $body.Add("icon", [notion_icon]::ConvertFromObject($icon))
        }

        if ($cover)
        {
            if ($cover -isnot [notion_file])
            {
                $cover = [notion_file]::ConvertToObject($cover)
            }
            $body.Add("cover", [notion_file]::ConvertFromObject($cover))
        }
    }
    catch
    {
        Write-Host -ForegroundColor Green "TS"
        Write-Host -ForegroundColor Cyan $properties
        Write-Error $_.Exception.Message
        Write-Host -ForegroundColor Magenta ($body | conertto-json)
        Write-Host -ForegroundColor Green "--"
    }
    try
    {
        $body = $body | Remove-NullValuesFromObject
        $response = Invoke-NotionAPICall -Method POST -uri "/pages" -Body $body
        return [notion_page]::ConvertFromObject($response)
    }
    catch
    {
        Write-Error $_.Exception.Message
    }
}
