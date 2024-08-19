#############################################################################################################
# Title: ConvertTo-TSNotionObject
# Description: 
# 07/2024 Thomas.Subotitsch@base-IT.at
# Minimum Powershell Version: 7
#Requires -Version "7"
#############################################################################################################
function ConvertTo-TSNotionObject
{
    <#
    .SYNOPSIS
    Converts an object to a TypeScript Notion object.
    
    .DESCRIPTION
    This function takes an object and converts it to a TypeScript Notion object.
    
    .PARAMETER Value
    The object to be converted.

    .PARAMETER Object
    The object to be converted. (Alias for Value)
    
    .OUTPUTS
    The converted TypeScript Notion object.
    
    .EXAMPLE
    $object = @{ Name = "John"; Age = 30 }
    $convertedObject = ConvertTo-TSNotionObject -Object $object

    .EXAMPLE
    $object = @{ Name = "John"; Age = 30 }
    $object | ConvertTo-TSNotionObject

    .EXAMPLE
    $object = @{ Name = "John"; Age = 30 }
    ConvertTo-TSNotionObject -value $object
    
    .NOTES
    Author: [Your Name]
    Date: [Current Date]
    #>
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true, HelpMessage = "The input object to convert to a Notion object based on classes")]
        [Alias("Object")]
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
            #TODO: Constructor für jede Klasse erstellen .ConvertfromObject() -> $Object = [NotionObject]::new().ConvertfromObject($Value)
            switch ($Value.object)
            {
                "list"
                {  
                    "List" | Add-TSNotionLogToFile -Level INFO 
                    #TODO: Gibt's einen Block Type List?
                    if ($Value.results -is [array])
                    {
                        foreach ($result in $Value.results)
                        {
                            $result | ConvertTo-TSNotionObject
                        }
                    }
                    #TODO: $out = [Block]::new()
                    # Block vom Typ List erstellen
                    # Children aus den Einzelobjekten hinzufügen
                }

                "block"
                {
                    "Block" | Add-TSNotionLogToFile -Level INFO 
                    switch ($value.type)
                    {
                        "paragraph"
                        {
                            "Paragraph" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "heading_1"
                        {
                            "Heading1" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "heading_2"
                        {
                            "Heading2" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "heading_3"
                        {
                            "Heading3" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "bulleted_list_item"
                        {
                            "BulletedListItem" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "numbered_list_item"
                        {
                            "NumberedListItem" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "to_do"
                        {
                            "ToDo" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "toggle"
                        {
                            "Toggle" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "child_page"
                        {
                            "ChildPage" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "unsupported"
                        {
                            "Unsupported" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        Default
                        {
                            "Unsupported" | Add-TSNotionLogToFile -Level WARN
                        }
                    
                    }
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
                    [page]::ConvertfromObject($value)
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
