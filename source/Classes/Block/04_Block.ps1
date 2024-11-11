class Block
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

    
    Block()
    {
        #$this.id = [guid]::NewGuid().ToString()
        $this.last_edited_time = [datetime]::Now.ToString("yyyy-MM-ddTHH:mm:ssZ")
        $this.created_time = $this.last_edited_time
    }

    # Block with array of children
    # [Block]::new(@($block1,$block2))
    Block([array] $children)
    {
        #$this.id = [guid]::NewGuid().ToString()
        $this.children = $children
        if ($children.count -gt 0)
        {
            $this.has_children = $true
        }
    }
    # Block with array of children and parent id
    # [Block]::new(@($block1,$block2), $parent)
    Block([array] $children, [string] $parent)
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

    static [Block] ConvertFromObject($Value)
    {
        $Block = $null
        switch ($Value.type)
        # https://developers.notion.com/reference/block#block-type-objects
        {
            "bookmark"
            {
                $Block = [bookmark]::ConvertfromObject($value)
                break
            }
            "breadcrumb"
            {
                $Block = [breadcrumb]::ConvertfromObject($value)
                break
            }
            "bulleted_list_item"
            {
                $Block = [bulleted_list_item]::ConvertfromObject($value)
                break
            }
            "callout"
            {
                $Block = [Callout]::ConvertfromObject($value)
                break
            }
            "child_database"
            {
                $Block = [child_database]::ConvertfromObject($value)
                break
            }
            "child_page"
            {
                $Block = [child_page]::ConvertfromObject($value)
                break
            }
            "code"
            {
                $Block = [Code]::ConvertfromObject($value)
                break
            }
            "column"
            {
                $Block = [column]::ConvertfromObject($value)
                break
            }
            "column_list"
            {
                $Block = [column_list]::ConvertfromObject($value)
                break
            }
            "divider"
            {
                $Block = [Divider]::ConvertfromObject($value)
                break
            }
            "embed"
            {
                $Block = [Embed]::ConvertfromObject($value)
                break
            }
            "equation"
            {
                $Block = [equation]::ConvertfromObject($value)
                break
            }
            "file"
            {
                $Block = [notion_file]::ConvertfromObject($value.file)
                break
            }
            "heading_1"
            {
                $Block = [heading]::ConvertfromObject($value)
                break
            }
            "heading_2"
            {
                $Block = [heading]::ConvertfromObject($value)
                break
            }
            "heading_3"
            {
                $Block = [heading]::ConvertfromObject($value)
                break
            }
            "image"
            {
                $Block = [Image]::ConvertfromObject($value.image)
                break
            }
            "link_preview"
            {
                $Block = [link_preview]::ConvertfromObject($value.link_preview)
                break
            }
            #Mention ??
            "mention"
            {
                # $Block = [??]
            }

            "numbered_list_item"
            {
                $Block = [numbered_list_item]::ConvertfromObject($value.numbered_list_item)
                break
            }
            "paragraph"
            {
                $Block = [paragraph]::ConvertfromObject($value.paragraph)
                break
            }
            "pdf"
            {
                $Block = [PDF]::ConvertfromObject($value.pdf)
                break
            }
            "quote"
            {
                $Block = [quote]::ConvertfromObject($value.quote)
                break
            }
            "synced_block"
            {
                $Block = [synced_block]::ConvertfromObject($value.synced_block)
                break
            }
            "table"
            {
                $Block = [table]::ConvertfromObject($value.table) 
                break
            }
            # "table_row"
            # {
            #     $Block =  [table_row]::ConvertfromObject($value.table_row)
            #     break
            # }
            "table_of_contents"
            {
                $Block = [table_of_contents]::ConvertfromObject($value.table_of_contents)
                break
            }
            "template"
            {
                Write-Error "Block type $($Value.type) is not supported anymore since 27.03.2023" -Category NotImplemented
                break
            }
            "to_do"
            {
                $Block = [to_do]::ConvertfromObject($value.to_do)
                break
            }
            "toggle"
            {
                $Block = [toggle]::ConvertfromObject($value.toggle)
                break
            }
            # "unsupported"
            # {
            #     $block =  [unsupported]::ConvertfromObject($value.unsupported)
            #     break
            # }
            "video"
            {
                $Block = [video]::ConvertfromObject($value.video)
                break
            }
            Default
            {
                $type = $null
                if ([System.Enum]::TryParse([blocktype], $Value.type, [ref]$type))
                {
                    Write-Error "Block type $($Value.type) not implemented yet" -Category NotImplemented -RecommendedAction "Please create a Github issue to request this feature"
                }
                else
                {
                    Write-Error "Unknown block type: $($Value.type)" -Category InvalidData -TargetObject $Value -RecommendedAction "Please provide a valid block type"
                }
            }
        
        }
        $Block.id = $Value.id
        #TODO: real parent object
        $Block.parent = [parent]::ConvertFromObject($Value.parent)
        $Block.created_time = $Value.created_time
        $Block.created_by = [user]::ConvertFromObject($Value.created_by)
        $Block.last_edited_time = $Value.last_edited_time
        $Block.last_edited_by = [user]::ConvertFromObject($Value.last_edited_by)
        $Block.archived = $Value.archived
        $Block.in_trash = $Value.in_trash
        $Block.has_children = $Value.has_children
        return $Block
    }
}
