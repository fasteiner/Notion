#############################################################################################################
# Title: 01_emoji
# Description: 
# 07/2024 Thomas.Subotitsch@base-IT.at
# Minimum Powershell Version: 7
#Requires -Version "7"
#############################################################################################################
class emoji {
    [string]$object = "emoji"
    [string]$emoji

    emoji($emoji)
    {
        $this.emoji = $emoji
    }
}
