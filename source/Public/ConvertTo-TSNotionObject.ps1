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
                "Template - not implemented yet" | Add-TSNotionLogToFile -Level WARN
                return
            }

        
        ("Object: {0} Type: {1}" -f $item.object, $item.Type) | Add-TSNotionLogToFile -Level DEBUG
            "Object", $item | Add-TSNotionLogToFile -Level DEBUG
            #TODO: Constructor für jede Klasse erstellen .ConvertfromObject() -> $Object = [NotionObject]::new().ConvertfromObject($item)
            switch ($item.object)
            {
                "list"
                {  
                    "List" | Add-TSNotionLogToFile -Level DEBUG
                    #TODO: Gibt's einen Object Type List?
                    if ($item.results -is [array])
                    {
                        foreach ($result in $item.results)
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
                    "Block" | Add-TSNotionLogToFile -Level DEBUG
                    switch ($item.type)
                    # https://developers.notion.com/reference/block#block-type-objects
                    {
                        "bookmark"
                        {
                            "Bookmark" | Add-TSNotionLogToFile -Level DEBUG
                            break
                        }
                        "breadcrumb"
                        {
                            "Breadcrumb" | Add-TSNotionLogToFile -Level DEBUG
                            break
                        }
                        "bulleted_list_item"
                        {
                            "bulleted_list_item" | Add-TSNotionLogToFile -Level DEBUG
                            break
                        }
                        "callout"
                        {
                            "Callout" | Add-TSNotionLogToFile -Level DEBUG
                            $output += [Callout]::ConvertfromObject($item)
                            break
                        }
                        "child_database"
                        {
                            "ChildDatabase" | Add-TSNotionLogToFile -Level DEBUG
                            break
                        }
                        "child_page"
                        {
                            "ChildPage" | Add-TSNotionLogToFile -Level DEBUG
                            break
                        }
                        "code"
                        {
                            "Code" | Add-TSNotionLogToFile -Level DEBUG
                            $output += [Code]::ConvertfromObject($item)
                            break
                        }
                        "column"
                        {
                            "Column" | Add-TSNotionLogToFile -Level DEBUG
                            break
                        }
                        "divider"
                        {
                            "Divider" | Add-TSNotionLogToFile -Level DEBUG
                            break
                        }
                        "embed"
                        {
                            "Embed" | Add-TSNotionLogToFile -Level DEBUG
                            break
                        }
                        "equation"
                        {
                            "Equation" | Add-TSNotionLogToFile -Level DEBUG
                            break
                        }
                        "file"
                        {
                            "File" | Add-TSNotionLogToFile -Level DEBUG
                            break
                        }
                        "heading_1"
                        {
                            "Heading1" | Add-TSNotionLogToFile -Level DEBUG
                            $output += [heading]::ConvertfromObject($item)
                            break
                        }
                        "heading_2"
                        {
                            "Heading2" | Add-TSNotionLogToFile -Level DEBUG
                            $output += [heading]::ConvertfromObject($item)
                            break
                        }
                        "heading_3"
                        {
                            "Heading3" | Add-TSNotionLogToFile -Level DEBUG
                            $output += [heading]::ConvertfromObject($item)
                            break
                        }
                        "image"
                        {
                            "Image" | Add-TSNotionLogToFile -Level DEBUG
                            break
                        }
                        "link_preview"
                        {
                            "LinkPreview" | Add-TSNotionLogToFile -Level DEBUG
                            break
                        }
                        #Mention ??
                        "numbered_list_item"
                        {
                            "numbered_list_item" | Add-TSNotionLogToFile -Level DEBUG
                            $output += [numbered_list_item]::ConvertfromObject($item)
                            break
                        }
                        "paragraph"
                        {
                            "Paragraph" | Add-TSNotionLogToFile -Level DEBUG
                            $output += [paragraph]::ConvertfromObject($item)
                            break
                        }
                        "pdf"
                        {
                            "Pdf" | Add-TSNotionLogToFile -Level DEBUG
                            break
                        }
                        "quote"
                        {
                            "Quote" | Add-TSNotionLogToFile -Level DEBUG
                            $output += [quote]::ConvertfromObject($item)
                            break
                        }
                        "synced_block"
                        {
                            "SyncedBlock" | Add-TSNotionLogToFile -Level DEBUG
                            break
                        }
                        "table"
                        {
                            "Table" | Add-TSNotionLogToFile -Level DEBUG
                            $output += [table]::ConvertfromObject($item) 
                            break
                        }
                        "table_row"
                        {
                            "TableRow" | Add-TSNotionLogToFile -Level DEBUG
                            break
                        }
                        "table_of_contents"
                        {
                            "TableOfContents" | Add-TSNotionLogToFile -Level DEBUG
                            break
                        }
                        # template ???
                        "to_do"
                        {
                            "ToDo" | Add-TSNotionLogToFile -Level DEBUG
                            $output += [to_do]::ConvertfromObject($item)
                            break
                        }
                        "toggle"
                        {
                            "Toggle" | Add-TSNotionLogToFile -Level DEBUG
                            break
                        }
                        "unsupported"
                        {
                            "Unsupported" | Add-TSNotionLogToFile -Level DEBUG
                            break
                        }
                        "video"
                        {
                            "Video" | Add-TSNotionLogToFile -Level DEBUG
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
                    "Comment" | Add-TSNotionLogToFile -Level DEBUG
                    $output += [comment]::ConvertfromObject($item)
                }
        
                "database"
                {
                    # https://developers.notion.com/reference/database
                    "Database" | Add-TSNotionLogToFile -Level DEBUG
                }
        
                "page"
                {
                    # https://developers.notion.com/reference/page
                    "Page" | Add-TSNotionLogToFile -Level DEBUG
                    $output += [page]::ConvertfromObject($item)
                }
        
                "page_or_database"
                {  
                    "PageOrDatabase" | Add-TSNotionLogToFile -Level DEBUG
                }
        
                "property_item"
                {  
                    "PropertyItem" | Add-TSNotionLogToFile -Level DEBUG
                }
        
                "user"
                {
                    # https://developers.notion.com/reference/user
                    "User" | Add-TSNotionLogToFile -Level DEBUG
                    $output += [user]::ConvertFromObject($item)
                }
                Default
                {
                    "Object: $($item.object) not recognized" | Add-TSNotionLogToFile -Level WARN
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
