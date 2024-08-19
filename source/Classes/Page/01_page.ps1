#############################################################################################################
# Title: 01_Page
# Description: 
# 07/2024 Thomas.Subotitsch@base-IT.at
# Minimum Powershell Version: 7
#Requires -Version "7"
#############################################################################################################

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
    [notion_file]       $icon
    [notion_file]       $cover
    [object]     $properties
    [page_parent]$parent
    [string]     $url
    [string]     $public_url

    #Constructors
    page()
    {
        $this.id = [guid]::NewGuid().ToString()
        $this.created_time = [datetime]::UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.fffZ")

    }
    
    page([string] $id)
    {
        $this.id = $id
    }

    #Methods
    #TODO: Wie kann man verhindern, dass diese Methode mit falschen Objekten aufgerufen wird? Oder mit einem Array of Objects?
    static [page] ConvertFromObject($Value)
    {
        if ($Value -is [System.Object] -and !($Value -is [string]) -and !($Value -is [int]) -and !($Value -is [bool]) -and $Value.Object -and ($Value.Object -eq "page"))
        {
            $page = [page]::new()
            $page.id = $Value.id
            $page.created_time = Get-Date $Value.created_time -Format "yyyy-MM-ddTHH:mm:ss.fffZ"
            $page.created_by = [user]::new($Value.created_by)
            $page.last_edited_time = Get-Date $Value.last_edited_time -Format "yyyy-MM-ddTHH:mm:ss.fffZ"
            $page.last_edited_by = [user]::new($Value.last_edited_by)
            $page.archived = $Value.archived
            $page.in_trash = $Value.in_trash
            $page.icon = $Value.icon
            $page.cover = $Value.cover
            $page.properties = $Value.properties
            $page.parent = [page_parent]::new($Value.page_id)
            $page.url = $Value.url
            $page.public_url = $Value.public_url
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

# https://developers.notion.com/reference/page-property-values#paginated-page-properties
# TODO: Müssen die auch alle extra Klassen sein?
