class notion_page
{
    #https://developers.notion.com/reference/page
    [string]     $object = "page"
    [string]     $id
    [string]     $created_time
    [notion_user]       $created_by
    [string]     $last_edited_time
    [notion_user]       $last_edited_by
    [bool]       $archived
    [bool]       $in_trash
    [notion_page_icon]      $icon
    [notion_file]    $cover
    [notion_pageproperties] $properties = @{}
    [notion_page_parent]    $parent
    [string]     $url
    [string]     $public_url
    [string]     $request_id
    $children = @()

    #Constructors
    notion_page()
    {
        $this.id = [guid]::NewGuid().ToString()
        $this.created_time = [datetime]::UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
    }

    notion_page([string]$title)
    {
        $this.id = [guid]::NewGuid().ToString()
        $this.created_time = [datetime]::UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
        $this.properties = [notion_title_page_property]::new($title)
    }


    notion_page([System.Object]$parent, $properties)
    {
        $this.created_time = [datetime]::UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
        if($parent -is [notion_page_parent])
        {
            $this.parent = $parent
        }
        else
        {
            $this.parent = [notion_page_parent]::ConvertFromObject($parent)
        }
        $this.properties = $properties
    }

    #Methods
    addChild($child, [string] $type)
    {
        $out = $child
        if ($child.type)
        {
            $out = $out | Select-Object -ExcludeProperty "type"
        }
        $this.children += @{
            "type"  = $type
            "$type" = $out
        }
    }
    addChild($child)
    {
        $out = $child
        $type = $child.type
        # remove type propety from child object
        if ($child.type)
        {
            $out = $out | Select-Object -ExcludeProperty "type"
        }
        $this.children += @{
            "type"  = $type
            "$type" = $out
        }
    }
    addChildren($children)
    {
        foreach ($child in $children)
        {
            $this.addChild($child)
        }
    }
    #TODO: Wie kann man verhindern, dass diese Methode mit falschen Objekten aufgerufen wird? Oder mit einem Array of Objects?
    static [notion_page] ConvertFromObject($Value)
    {
        if (($Value -is [System.Object]) -and !($Value -is [string]) -and !($Value -is [int]) -and !($Value -is [bool]) -and $Value.Object -and ($Value.Object -eq "page"))
        {
            $page = [notion_page]::new()
            $page.id = $Value.id
            $page.created_time = ConvertTo-TSNotionFormattedDateTime -InputDate $Value.created_time -fieldName "created_time"
            $page.created_by = [notion_user]::new($Value.created_by)
            $page.last_edited_time = ConvertTo-TSNotionFormattedDateTime -InputDate $Value.last_edited_time -fieldName "last_edited_time"
            $page.last_edited_by = [notion_user]::new($Value.last_edited_by)
            $page.archived = $Value.archived
            $page.in_trash = $Value.in_trash
            #$page.icon = $Value.icon
            $page.icon = [notion_page_icon]::ConvertFromObject($Value.icon)
            
            $page.cover = [notion_file]::ConvertFromObject($Value.cover) 
            # https://developers.notion.com/reference/page-property-values#paginated-page-properties
            #TODO Konvertierung aller Properties in Klassen
            #$page.properties = [notion_pageproperties]::ConvertFromObject($Value.properties)
            $page.properties = $Value.properties
            $page.parent = [notion_parent]::ConvertFromObject($Value.parent)
            $page.url = $Value.url
            $page.public_url = $Value.public_url
            $page.archived = $Value.archived ? $Value.archived : $false
            $page.in_trash = $Value.in_trash ? $Value.in_trash : $false
            #BUG warum wird das nicht befüllt?
            $page.request_id = $Value.request_id ? $Value.request_id : $null
            return $page
        }
        else
        {
            if ($Value.Object -ne "page")
            {
                "Provided value's object type is ""$($Value.Object)"" instead of ""page""" | Add-TSNotionLogToFile -Level ERROR
            }
            else
            {
                "Provided value is type [$($Value.GetType().Name)] instead of [object]" | Add-TSNotionLogToFile -Level ERROR
            }
            return $null
        }
    }

    # static [notion_page] ConvertToISO8601($date)
    # {
    #     Write-Output $date
    #     return (Get-Date $date -Format "yyyy-MM-ddTHH:mm:ss.fffZ" )
    # }
}
