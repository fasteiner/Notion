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
    [file]       $icon
    [file]       $cover
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
    #BUG: Warum ist diese Methode nicht via [page]::ConvertfromObject($Value) verfügbar?
    ConvertFromObject($Value)
    {
        $this.id = $Value.id
        $this.created_time = $Value.created_time
        $this.created_by = $Value.created_by
        $this.last_edited_time = $Value.last_edited_time
        $this.last_edited_by = $Value.last_edited_by
        $this.archived = $Value.archived
        $this.in_trash = $Value.in_trash
        $this.icon = $Value.icon
        $this.cover = $Value.cover
        $this.properties = $Value.properties
        $this.parent = [page_parent]::new($Value.parent)
        $this.url = $Value.url
        $this.public_url = $Value.public_url
    }
}

# https://developers.notion.com/reference/page-property-values#paginated-page-properties
# TODO: Müssen die auch alle extra Klassen sein?
