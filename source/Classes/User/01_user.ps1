#############################################################################################################
# Title: 01_user
# Description: 
# 07/2024 Thomas.Subotitsch@base-IT.at
# Minimum Powershell Version: 7
#Requires -Version "7"
#############################################################################################################
class user {
    # https://developers.notion.com/reference/user
    [string]$object = "user"
    [string]$id
    [string]$type
    [string]$name
    [string]$avatar_url

    ConvertFromObject($Value)
    {
        $this.id = $Value.id
        $this.type = $Value.type
        $this.name = $Value.name
        $this.avatar_url = $Value.avatar_url
    }
}
