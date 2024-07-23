#############################################################################################################
# Title: 03_external_file
# Description: 
# 07/2024 Thomas.Subotitsch@base-IT.at
# Minimum Powershell Version: 7
#Requires -Version "7"
#############################################################################################################
class external_file {
    [string]$url

    external_file($url)
    {
        $this.url = $url
    }
}
