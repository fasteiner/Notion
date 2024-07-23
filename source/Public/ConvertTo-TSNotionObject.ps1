#############################################################################################################
# Title: ConvertTo-TSNotionObject
# Description: 
# 07/2024 Thomas.Subotitsch@base-IT.at
# Minimum Powershell Version: 7
#Requires -Version "7"
#############################################################################################################
function ConvertTo-TSNotionObject
{
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true, HelpMessage = "The input object to convert to a Notion object based on classes")]
        $Value
    )
    

    begin
    {
        # if ($_) { $Value = $_ }
        # $Value.GetType().BaseType
        # if (!(($Value -is [System.Object]) -or ($Value -is [System.Array])))
        # {
        #     $Type = $Value.GetType().BaseType
        #     "Input is not an array or object (is $Type)" | Add-TSNotionLogToFile -Level ERROR
        #     Break
        # }
    }
    process
    {
        foreach ($item in $Value)
        {
        
        
        ("Object: {0} Type: {1} " -f $Value.object, $Value.Type) | Add-TSNotionLogToFile -Level INFO
            "Object", $Value | Add-TSNotionLogToFile -Level DEBUG
        
            # $Value| Get-Member -MemberType Properties | ForEach-Object {
            #     $Property = $_.Name
            #     $Value = $Value.$Property
            #     $Property, $Value | Add-TSNotionLogToFile -Level INFO
            # }

            #TODO: Constructor für jede Klasse erstellen .ConvertfromObject() -> $Object = [NotionObject]::new().ConvertfromObject($Value)
                switch ($Value.object)
                {
                    "block"
                    {
                        "Block" | Add-TSNotionLogToFile -Level INFO 
                    }
        
                    "comment"
                    {  
                        "Comment" | Add-TSNotionLogToFile -Level INFO 
                    }
        
                    "database"
                    {  
                        "Database" | Add-TSNotionLogToFile -Level INFO 
                    }
        
                    "page"
                    {  
                        "Page" | Add-TSNotionLogToFile -Level INFO 
                    }
        
                    "page_or_database"
                    {  
                        "PageOrDatabase" | Add-TSNotionLogToFile -Level INFO 
                    }
        
                    "property_item"
                    {  
                        "PropertyItem" | Add-TSNotionLogToFile -Level INFO 
                    }
        
                    "user"
                    {  
                        "User" | Add-TSNotionLogToFile -Level INFO 
                    }
                    Default
                    {
                    }
                }
            "-" * 50
            Break
        }
    }
    end
    {
    }
}
