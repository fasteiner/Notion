class block
# https://developers.notion.com/reference/block
{
    $object = "block"
    $id = $null
    $parent = $null
    #$after = ""
    $children = @()
    [string]$created_time
    [user]$created_by
    [string]$last_edited_time
    [user]$last_edited_by
    [bool]$archived = $false
    [bool]$in_trash = $false
    [bool]$has_children = $false

    
    block()
    {
        #$this.id = [guid]::NewGuid().ToString()
        $this.last_edited_time = [datetime]::Now.ToString("yyyy-MM-ddTHH:mm:ssZ")
        $this.created_time = $this.last_edited_time
    }

    # block with array of children
    # [block]::new(@($block1,$block2))
    block([array] $children)
    {
        #$this.id = [guid]::NewGuid().ToString()
        $this.children = $children
        if ($children.count -gt 0)
        {
            $this.has_children = $true
        }
    }
    # block with array of children and parent id
    # [block]::new(@($block1,$block2), $parent)
    block([array] $children, [string] $parent)
    {
        #$this.id = [guid]::NewGuid().ToString()
        $this.children = $children
        $this.parent = @{
            "type"     = "block_id"
            "block_id" = $parent
        }
        if ($children.count -gt 0)
        {
            $this.has_children = $true
        }
    }
    addChild($child, [string] $type)
    {
        $out = $child
        if ($child.type)
        {
            $out = $out | Select-Object -ExcludeProperty "type"
        }
        $this.children += @{
            "type"  = $type
            "$type" = $out
        }
        $this.has_children = $true
    }
    addChild($child)
    {
        $out = $child
        $type = $child.type
        # remove type propety from child object
        if ($child.type)
        {
            $out = $out | Select-Object -ExcludeProperty "type"
        }
        $this.children += @{
            "type"  = $type
            "$type" = $out
        }
    }

    static [block] ConvertFromObject($Value)
    {
        $block = $null
        switch ($Value.type)
        # https://developers.notion.com/reference/block#block-type-objects
        {
            "bookmark"
            {
                $block = [bookmark]::ConvertfromObject($value)
                break
            }
            "breadcrumb"
            {
                $block = [breadcrumb]::ConvertfromObject($value)
                break
            }
            "bulleted_list_item"
            {
                $block = [bulleted_list_item]::ConvertfromObject($value)
                break
            }
            "callout"
            {
                $block = [Callout]::ConvertfromObject($value)
                break
            }
            "child_database"
            {
                $block = [child_database]::ConvertfromObject($value)
                break
            }
            "child_page"
            {
                $block = [child_page]::ConvertfromObject($value)
                break
            }
            "code"
            {
                $block = [Code]::ConvertfromObject($value)
                break
            }
            "column"
            {
                $block = [column]::ConvertfromObject($value)
                break
            }
            "column_list"
            {
                $block = [column_list]::ConvertfromObject($value)
                break
            }
            "divider"
            {
                $block = [Divider]::ConvertfromObject($value)
                break
            }
            "embed"
            {
                $block = [Embed]::ConvertfromObject($value)
                break
            }
            "equation"
            {
                $block = [equation]::ConvertfromObject($value)
                break
            }
            "file"
            {
                $block = [notion_file]::ConvertfromObject($value.file)
                break
            }
            "heading_1"
            {
                $block = [heading]::ConvertfromObject($value)
                break
            }
            "heading_2"
            {
                $block = [heading]::ConvertfromObject($value)
                break
            }
            "heading_3"
            {
                $block = [heading]::ConvertfromObject($value)
                break
            }
            "image"
            {
                $block = [Image]::ConvertfromObject($value.image)
                break
            }
            "link_preview"
            {
                $block = [link_preview]::ConvertfromObject($value.link_preview)
                break
            }
            #Mention ??
            "mention"
            {
                # $block = [??]
            }

            "numbered_list_item"
            {
                $block = [numbered_list_item]::ConvertfromObject($value.numbered_list_item)
                break
            }
            "paragraph"
            {
                $block = [paragraph]::ConvertfromObject($value.paragraph)
                break
            }
            "pdf"
            {
                $block = [PDF]::ConvertfromObject($value.pdf)
                break
            }
            "quote"
            {
                $block = [quote]::ConvertfromObject($value.quote)
                break
            }
            "synced_block"
            {
                $block = [synced_block]::ConvertfromObject($value.synced_block)
                break
            }
            "table"
            {
                $block = [table]::ConvertfromObject($value.table) 
                break
            }
            # "table_row"
            # {
            #     $block =  [table_row]::ConvertfromObject($value.table_row)
            #     break
            # }
            "table_of_contents"
            {
                $block = [table_of_contents]::ConvertfromObject($value.table_of_contents)
                break
            }
            "template"
            {
                Write-Error "block type $($Value.type) is not supported anymore since 27.03.2023" -Category NotImplemented
                break
            }
            "to_do"
            {
                $block = [to_do]::ConvertfromObject($value.to_do)
                break
            }
            "toggle"
            {
                $block = [toggle]::ConvertfromObject($value.toggle)
                break
            }
            # "unsupported"
            # {
            #     $block =  [unsupported]::ConvertfromObject($value.unsupported)
            #     break
            # }
            "video"
            {
                $block = [video]::ConvertfromObject($value.video)
                break
            }
            Default
            {
                $type = $null
                if ([System.Enum]::TryParse([blocktype], $Value.type, [ref]$type))
                {
                    Write-Error "block type $($Value.type) not implemented yet" -Category NotImplemented -RecommendedAction "Please create a Github issue to request this feature"
                }
                else
                {
                    Write-Error "Unknown block type: $($Value.type)" -Category InvalidData -TargetObject $Value -RecommendedAction "Please provide a valid block type"
                }
            }
        
        }
        $block.id = $Value.id
        #TODO: real parent object
        $block.parent = [parent]::ConvertFromObject($Value.parent)
        $block.created_time = $Value.created_time
        $block.created_by = [user]::ConvertFromObject($Value.created_by)
        $block.last_edited_time = $Value.last_edited_time
        $block.last_edited_by = [user]::ConvertFromObject($Value.last_edited_by)
        $block.archived = $Value.archived
        $block.in_trash = $Value.in_trash
        $block.has_children = $Value.has_children
        return $block
    }
}
