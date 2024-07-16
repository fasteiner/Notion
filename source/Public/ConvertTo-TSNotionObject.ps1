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
        $Input
    )
    

    begin
    {
    }
    process
    {
        ("Object: {0} Type: {1} " -f $Input.object, $Input.Type) | Add-TSNotionLogToFile -Level INFO
        "Object", $Input | Add-TSNotionLogToFile -Level DEBUG
        
        # $Input| Get-Member -MemberType Properties | ForEach-Object {
        #     $Property = $_.Name
        #     $Value = $Input.$Property
        #     $Property, $Value | Add-TSNotionLogToFile -Level INFO
        # }

        #TODO: Constructor für jede Klasse erstellen .ConvertfromObject() -> $Object = [NotionObject]::new().ConvertfromObject($Input)
        #     switch ($type)
        #     {
        #         "block"
        #         {
        #             "Block" | Add-LogToFile -Level INFO 
        #         }
        
        #         "comment"
        #         {  
        #         }
        
        #         "database"
        #         {  
        #         }
        
        #         "page"
        #         {  
        #         }
        
        #         "page_or_database"
        #         {  
        #         }
        
        #         "property_item"
        #         {  
        #         }
        
        #         "user"
        #         {  
        #         }
        #         Default
        #         {
        #         }
        #     }
        # }
        "-" * 50
        Break
    }
    end
    {
    }
}


    
