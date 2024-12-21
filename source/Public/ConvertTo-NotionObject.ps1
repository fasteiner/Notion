function ConvertTo-NotionObject
{
    <#
    .SYNOPSIS
    Converts an object to a TypeScript Notion object.
    
    .DESCRIPTION
    This function takes an object and converts it to a TypeScript Notion object.
    
    .PARAMETER InputObject
    The object to be converted.

    .PARAMETER Object
    The object to be converted. (Alias for InputObject)
    
    .OUTPUTS
    The converted Notion object.
    
    .EXAMPLE
    $object = @{ object = "block"; type = "code" }
    $convertedObject = ConvertTo-NotionObject -Object $object

    Returns an block object of type "code".

    .EXAMPLE
    $object = @{ object = "list"; results = @(@{ object = "block"; type = "paragraph" }, @{ object = "block"; type = "heading_1" }) }
    $object | ConvertTo-NotionObject

    Returns a list object with two block objects of type "paragraph" and "heading_1".

    .EXAMPLE
    $object = @{ object = "block"; type = "bookmark" }
    ConvertTo-NotionObject -InputObject $object

    Returns a block object of type "bookmark".    
    #>
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true, HelpMessage = "The input object to convert to a Notion object based on classes")]
        [Alias("Object")]
        $InputObject
    )
    

    begin
    {
        # if ($_) { $InputObject = $_ }
        # $InputObject.GetType().BaseType
        # if (!(($InputObject -is [System.Object]) -or ($InputObject -is [System.Array])))
        # {
        #     $Type = $InputObject.GetType().BaseType
        #     "Input is not an array or object (is $Type)" | Add-NotionLogToFile -Level ERROR
        #     Break
        # }
        $output = @()
    }
    process
    {
        foreach ($item in $InputObject)
        {
            if ($item.template)
            {
                "Template - not implemented yet" | Add-NotionLogToFile -Level WARN
                return
            }

        
        ("Object: {0} Type: {1}" -f $item.object, $item.Type) | Add-NotionLogToFile -Level DEBUG
            "Object", $item | Add-NotionLogToFile -Level DEBUG
            #TODO: Constructor für jede Klasse erstellen .ConvertfromObject() -> $Object = [NotionObject]::new().ConvertfromObject($item)
            switch ($item.object)
            {
                "list"
                {  
                    "List" | Add-NotionLogToFile -Level DEBUG
                    #TODO: Gibt's einen Object Type List?
                    if ($item.results -is [array])
                    {
                        foreach ($result in $item.results)
                        {
                            $result | ConvertTo-NotionObject
                        }
                    }
                    #TODO: $out = [notion_block]::new()
                    # Block vom Typ List erstellen
                    # Children aus den Einzelobjekten hinzufügen
                }

                "block"
                {
                    # https://developers.notion.com/reference/block
                    "Block" | Add-NotionLogToFile -Level DEBUG
                    $output += [notion_block]::ConvertFromObject($item)
                }
        
                "comment"
                {  
                    "Comment" | Add-NotionLogToFile -Level DEBUG
                    $output += [notion_comment]::ConvertfromObject($item)
                }
        
                "database"
                {
                    # https://developers.notion.com/reference/database
                    $output += [notion_database]::ConvertFromObject($item)
                    "Database" | Add-NotionLogToFile -Level DEBUG
                }
        
                "page"
                {
                    # https://developers.notion.com/reference/page
                    "Page" | Add-NotionLogToFile -Level DEBUG
                    $output += [notion_page]::ConvertfromObject($item)
                }
        
                "page_or_database"
                {  
                    "PageOrDatabase" | Add-NotionLogToFile -Level DEBUG
                }
        
                "property_item"
                {  
                    "PropertyItem" | Add-NotionLogToFile -Level DEBUG
                }
        
                "user"
                {
                    # https://developers.notion.com/reference/user
                    "User" | Add-NotionLogToFile -Level DEBUG
                    $output += [notion_user]::ConvertFromObject($item)
                }
                Default
                {
                    "Object: $($item.object) not recognized" | Add-NotionLogToFile -Level WARN
                }
            }
            #Break
        }
    }
    end
    {
        return $output
    }
}
