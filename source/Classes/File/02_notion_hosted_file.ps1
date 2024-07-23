#############################################################################################################
# Title: 02_notion_hosted_file
# Description: 
# 07/2024 Thomas.Subotitsch@base-IT.at
# Minimum Powershell Version: 7
#Requires -Version "7"
#############################################################################################################
class notion_hosted_file {
    [string]$url
    [string]$expiry_time

    notion_hosted_file($url, $expiry_time)
    {
        $this.url = $url
        $this.expiry_time = Get-Date $expiry_time -Format "yyyy-MM-ddTHH:mm:ss.fffZ"
    }
}
