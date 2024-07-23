#############################################################################################################
# Title: 02_sub-type
# Description: 
# 07/2024 Thomas.Subotitsch@base-IT.at
# Minimum Powershell Version: 7
#Requires -Version "7"
#############################################################################################################
class sub-type {
    # https://developers.notion.com/reference/unfurl-attribute-object#inline-sub-type-objects
    $color
    $date
    $datetime
    $enum
    $plain_text
    $title

    sub-type($color, $date, $datetime, $enum, $plain_text, $title)
    {
        $this.color = $color
        $this.date = $date
        $this.datetime = $datetime
        $this.enum = $enum
        $this.plain_text = $plain_text
        $this.title = $title
    }

    
}
