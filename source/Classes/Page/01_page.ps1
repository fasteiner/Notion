class page
{
    #https://developers.notion.com/reference/page
    [string]     $object = "page"
    [string]     $id
    [string]     $created_time
    [user]       $created_by
    [string]     $last_edited_time
    [user]       $last_edited_by
    [bool]       $archived
    [bool]       $in_trash
    [page_icon]      $icon
    [notion_file]    $cover
    #[PageProperties] $properties
    [object] $properties
    [page_parent]    $parent
    [string]     $url
    [string]     $public_url
    [string]     $request_id
    $children = @()

    #Constructors
    page()
    {
        $this.id = [guid]::NewGuid().ToString()
        $this.created_time = [datetime]::UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
    }

    page([string]$title)
    {
        $this.id = [guid]::NewGuid().ToString()
        $this.created_time = [datetime]::UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
        $this.properties = [pp_title]::new($title)
    }


    page([System.Object]$parent, $properties)
    {
        $this.created_time = [datetime]::UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
        $this.parent = [page_parent]::new($parent)
        #TODO properties depending of parent.type (page_id or database_id)
        # if ($parent.type -eq "database_id")
        # {
        #     #TODO
        #     $this.properties = $properties
        # }
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
    static [page] ConvertFromObject($Value)
    {
        if (($Value -is [System.Object]) -and !($Value -is [string]) -and !($Value -is [int]) -and !($Value -is [bool]) -and $Value.Object -and ($Value.Object -eq "page"))
        {
            $page = [page]::new()
            $page.id = $Value.id
            $page.created_time = Get-Date $Value.created_time -Format "yyyy-MM-ddTHH:mm:ss.fffZ"
            $page.created_by = [user]::new($Value.created_by)
            $page.last_edited_time = Get-Date $Value.last_edited_time -Format "yyyy-MM-ddTHH:mm:ss.fffZ"
            $page.last_edited_by = [user]::new($Value.last_edited_by)
            $page.archived = $Value.archived
            $page.in_trash = $Value.in_trash
            #$page.icon = $Value.icon
            switch ($Value.icon.type)
            {
                "notion_file"
                {
                    $page.icon = [notion_file]::new($Value.icon.external.url) 
                }
                "emoji"
                {
                    $page.icon = [emoji]::new($Value.icon.emoji) 
                }
            }
            switch ($Value.cover.type)
            {
                "external"
                {
                    $page.cover = [external_file]::new($Value.cover.external.url) 
                }
            }
            # https://developers.notion.com/reference/page-property-values#paginated-page-properties
            #TODO Konvertierung aller Properties in Klassen
            #$page.properties = [PageProperties]::ConvertFromObject($Value.properties)
            $page.properties = $Value.properties
            $page.parent = [page_parent]::new($Value.parent)
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

    # static [page] ConvertToISO8601($date)
    # {
    #     Write-Output $date
    #     return (Get-Date $date -Format "yyyy-MM-ddTHH:mm:ss.fffZ" )
    # }
}
