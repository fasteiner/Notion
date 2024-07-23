#############################################################################################################
# Title: 02_page_parent
# Description: 
# 07/2024 Thomas.Subotitsch@base-IT.at
# Minimum Powershell Version: 7
#Requires -Version "7"
#############################################################################################################
class page_parent
{
    # https://developers.notion.com/reference/parent-object
    [string]$type
    [string]$page_id

    page_parent([string] $page_id)
    {
        $this.type = "page_id"
        $this.page_id = $page_id
    }
}
