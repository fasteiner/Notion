function ConvertTo-TSNotionObject
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
    $convertedObject = ConvertTo-TSNotionObject -Object $object

    Returns an block object of type "code".

    .EXAMPLE
    $object = @{ object = "list"; results = @(@{ object = "block"; type = "paragraph" }, @{ object = "block"; type = "heading_1" }) }
    $object | ConvertTo-TSNotionObject

    Returns a list object with two block objects of type "paragraph" and "heading_1".

    .EXAMPLE
    $object = @{ object = "block"; type = "bookmark" }
    ConvertTo-TSNotionObject -InputObject $object

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
        #     "Input is not an array or object (is $Type)" | Add-TSNotionLogToFile -Level ERROR
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
                "Template" | Add-TSNotionLogToFile -Level INFO
                exit
            }

        
        ("Object: {0} Type: {1} " -f $InputObject.object, $InputObject.Type) | Add-TSNotionLogToFile -Level INFO
            "Object", $InputObject | Add-TSNotionLogToFile -Level DEBUG
            #TODO: Constructor für jede Klasse erstellen .ConvertfromObject() -> $Object = [NotionObject]::new().ConvertfromObject($InputObject)
            switch ($InputObject.object)
            {
                "list"
                {  
                    "List" | Add-TSNotionLogToFile -Level INFO 
                    #TODO: Gibt's einen Object Type List?
                    if ($InputObject.results -is [array])
                    {
                        foreach ($result in $InputObject.results)
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
                    # https://developers.notion.com/reference/block
                    "Block" | Add-TSNotionLogToFile -Level INFO 
                    switch ($InputObject.type)
                    # https://developers.notion.com/reference/block#block-type-objects
                    {
                        "bookmark"
                        {
                            "Bookmark" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "breadcrumb"
                        {
                            "Breadcrumb" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "bulleted_list_item"
                        {
                            "BulletedListItem" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "callout"
                        {
                            "Callout" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "child_database"
                        {
                            "ChildDatabase" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "child_page"
                        {
                            "ChildPage" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "code"
                        {
                            "Code" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "column"
                        {
                            "Column" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "divider"
                        {
                            "Divider" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "embed"
                        {
                            "Embed" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "equation"
                        {
                            "Equation" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "file"
                        {
                            "File" | Add-TSNotionLogToFile -Level INFO 
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
                        "image"
                        {
                            "Image" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "link_preview"
                        {
                            "LinkPreview" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        #Mention ??
                        "numbered_list_item"
                        {
                            "numbered_list_item" | Add-TSNotionLogToFile -Level INFO
                            $output += [numbered_list_item]::ConvertfromObject($InputObject)
                            break
                        }
                        "paragraph"
                        {
                            "Paragraph" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "pdf"
                        {
                            "Pdf" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "quote"
                        {
                            "Quote" | Add-TSNotionLogToFile -Level INFO
                            $output += [quote]::ConvertfromObject($InputObject)
                            break
                        }
                        "synced_block"
                        {
                            "SyncedBlock" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "table"
                        {
                            "Table" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "table_row"
                        {
                            "TableRow" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "table_of_contents"
                        {
                            "TableOfContents" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        # template ???
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
                        "unsupported"
                        {
                            "Unsupported" | Add-TSNotionLogToFile -Level INFO 
                            break
                        }
                        "video"
                        {
                            "Video" | Add-TSNotionLogToFile -Level INFO 
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
                    $output += [comment]::ConvertfromObject($InputObject)
                }
        
                "database"
                {
                    # https://developers.notion.com/reference/database
                    "Database" | Add-TSNotionLogToFile -Level INFO 
                }
        
                "page"
                {
                    # https://developers.notion.com/reference/page
                    "Page" | Add-TSNotionLogToFile -Level INFO 
                    $output += [page]::ConvertfromObject($InputObject)
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
                    # https://developers.notion.com/reference/user
                    "User" | Add-TSNotionLogToFile -Level INFO 
                    $output += [user]::ConvertFromObject($InputObject)
                }
                Default
                {
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
