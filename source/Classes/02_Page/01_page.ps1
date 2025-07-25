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
    [notion_icon]      $icon
    [notion_file]    $cover
    [notion_pageproperties] $properties = @{}
    [notion_parent]    $parent
    [string]     $url
    [string]     $public_url
    [string]     $request_id

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
        if($parent -is [notion_parent])
        {
            $this.parent = $parent
        }
        else
        {
            $this.parent = [notion_parent]::ConvertFromObject($parent)
        }
        $this.properties = $properties
    }

    static [notion_page] ConvertFromObject($Value)
    {
        if (($Value -is [System.Object]) -and !($Value -is [string]) -and !($Value -is [int]) -and !($Value -is [bool]) -and $Value.Object -and ($Value.Object -eq "page"))
        {
            $page = [notion_page]::new()
            $page.id = $Value.id
            $page.created_time = ConvertTo-NotionFormattedDateTime -InputDate ($Value.created_time ?? (get-date)) -fieldName "created_time"
            $page.created_by = [notion_user]::ConvertFromObject($Value.created_by)
            $page.last_edited_time = ConvertTo-NotionFormattedDateTime -InputDate ($Value.last_edited_time ?? (get-date)) -fieldName "last_edited_time"
            $page.last_edited_by = [notion_user]::ConvertFromObject($Value.last_edited_by)
            $page.archived = $Value.archived
            $page.in_trash = $Value.in_trash
            #$page.icon = $Value.icon
            $page.icon = [notion_icon]::ConvertFromObject($Value.icon)
            
            $page.cover = [notion_file]::ConvertFromObject($Value.cover) 
            # https://developers.notion.com/reference/page-property-values#paginated-page-properties
            #TODO Konvertierung aller Properties in Klassen
            $page.properties = [notion_pageproperties]::ConvertFromObject($Value.properties)
            # $page.properties = $Value.properties
            $page.parent = [notion_parent]::ConvertFromObject($Value.parent)
            $page.url = $Value.url
            $page.public_url = $Value.public_url
            $page.archived = $Value.archived ? $Value.archived : $false
            $page.in_trash = $Value.in_trash ? $Value.in_trash : $false
            $page.request_id = $Value.request_id ? $Value.request_id : $null
            return $page
        }
        else
        {
            if ($Value.Object -ne "page")
            {
                "Provided value's object type is ""$($Value.Object)"" instead of ""page""" | Add-NotionLogToFile -Level ERROR
            }
            else
            {
                "Provided value is type [$($Value.GetType().Name)] instead of [object]" | Add-NotionLogToFile -Level ERROR
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
