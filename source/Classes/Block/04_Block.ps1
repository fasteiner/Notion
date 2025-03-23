class notion_block
# https://developers.notion.com/reference/block
{
    $object = "block"
    $id = $null
    [notion_parent]$parent = $null
    #$after = ""
    $children = @()
    [string]$created_time
    [notion_user]$created_by
    [string]$last_edited_time
    [notion_user]$last_edited_by
    [bool]$archived = $false
    [bool]$in_trash = $false
    [bool]$has_children = $false

    
    notion_block()
    {
        #$this.id = [guid]::NewGuid().ToString()
        $this.last_edited_time = [datetime]::Now.ToString("yyyy-MM-ddTHH:mm:ssZ")
        $this.created_time = $this.last_edited_time
    }

    # Block with array of children
    # [notion_block]::new(@($block1,$block2))
    notion_block([array] $children)
    {
        #$this.id = [guid]::NewGuid().ToString()
        $this.children = $children
        if ($children.count -gt 0)
        {
            $this.has_children = $true
        }
    }
    # Block with array of children and parent id
    # [notion_block]::new(@($block1,$block2), $parent)
    notion_block([array] $children, [string] $parent)
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

    static [notion_block] ConvertFromObject($Value)
    {
        # Write-Verbose "[notion_block]::ConvertFromObject($($Value | ConvertTo-Json -Depth 10 ))"
        $notion_block = $null
        switch ($Value.type)
        # https://developers.notion.com/reference/block#block-type-objects
        {
            "bookmark"
            {
                $notion_block = [notion_bookmark_block]::ConvertfromObject($value)
                break
            }
            "breadcrumb"
            {
                $notion_block = [notion_breadcrumb_block]::ConvertfromObject($value)
                break
            }
            "bulleted_list_item"
            {
                $notion_block = [notion_bulleted_list_item_block]::ConvertfromObject($value)
                break
            }
            "callout"
            {
                $notion_block = [notion_callout_block]::ConvertfromObject($value)
                break
            }
            "child_database"
            {
                $notion_block = [notion_child_database_block]::ConvertfromObject($value)
                break
            }
            "child_page"
            {
                $notion_block = [notion_child_page_block]::ConvertfromObject($value)
                break
            }
            "code"
            {
                $notion_block = [notion_code_block]::ConvertfromObject($value)
                break
            }
            "column"
            {
                $notion_block = [notion_column_block]::ConvertfromObject($value)
                break
            }
            "column_list"
            {
                $notion_block = [notion_column_list_block]::ConvertfromObject($value)
                break
            }
            "divider"
            {
                $notion_block = [notion_divider_block]::ConvertfromObject($value)
                break
            }
            "embed"
            {
                $notion_block = [notion_embed_block]::ConvertfromObject($value)
                break
            }
            "equation"
            {
                $notion_block = [notion_equation_block]::ConvertfromObject($value)
                break
            }
            "file"
            {
                $notion_block = [notion_file_block]::ConvertfromObject($value)
                break
            }
            "heading_1"
            {
                $notion_block = [notion_heading_block]::ConvertfromObject($value)
                break
            }
            "heading_2"
            {
                $notion_block = [notion_heading_block]::ConvertfromObject($value)
                break
            }
            "heading_3"
            {
                $notion_block = [notion_heading_block]::ConvertfromObject($value)
                break
            }
            "image"
            {
                $notion_block = [notion_image_block]::ConvertfromObject($value)
                break
            }
            "link_preview"
            {
                $notion_block = [notion_link_preview_block]::ConvertfromObject($value)
                break
            }
            #Mention ??
            "mention"
            {
                # $notion_block = [??]
            }

            "numbered_list_item"
            {
                $notion_block = [notion_numbered_list_item_block]::ConvertfromObject($value)
                break
            }
            "paragraph"
            {
                $notion_block = [notion_paragraph_block]::ConvertfromObject($value)
                break
            }
            "pdf"
            {
                $notion_block = [notion_pdf_block]::ConvertfromObject($value)
                break
            }
            "quote"
            {
                $notion_block = [notion_quote_block]::ConvertfromObject($value)
                break
            }
            "synced_block"
            {
                $notion_block = [notion_synced_block]::ConvertfromObject($value)
                break
            }
            "table"
            {
                $notion_block = [notion_table_block]::ConvertfromObject($value) 
                break
            }
            "table_row"
            {
                $notion_block =  [notion_table_row_block]::ConvertfromObject($value)
                break
            }
            "table_of_contents"
            {
                $notion_block = [notion_table_of_contents_block]::ConvertfromObject($value)
                break
            }
            "template"
            {
                Write-Error "Block type $($Value.type) is not supported anymore since 27.03.2023" -Category NotImplemented
                break
            }
            "to_do"
            {
                $notion_block = [notion_to_do_block]::ConvertfromObject($value)
                break
            }
            "toggle"
            {
                $notion_block = [notion_toggle_block]::ConvertfromObject($value)
                break
            }
            # "unsupported"
            # {
            #     $notion_block =  [unsupported]::ConvertfromObject($value.unsupported)
            #     break
            # }
            "video"
            {
                $notion_block = [notion_video_block]::ConvertfromObject($value)
                break
            }
            Default
            {
                $type = $null
                if ([System.Enum]::TryParse([notion_blocktype], $Value.type, [ref]$type))
                {
                    Write-Error "Block type $($Value.type) not implemented yet" -Category NotImplemented -RecommendedAction "Please create a Github issue to request this feature"
                }
                else
                {
                    Write-Error "Unknown block type: $($Value.type)" -Category InvalidData -TargetObject $Value -RecommendedAction "Please provide a valid block type"
                }
            }
        
        }
        $notion_block.id = $Value.id
        $notion_block.parent = [notion_parent]::ConvertFromObject($Value.parent)
        if($Value.created_time){
            $notion_block.created_time = ConvertTo-NotionFormattedDateTime -InputDate $Value.created_time -fieldName "created_time"
        }
        $notion_block.created_by = [notion_user]::ConvertFromObject($Value.created_by)
        if($value.last_edited_time){
            $notion_block.last_edited_time = ConvertTo-NotionFormattedDateTime -InputDate $Value.last_edited_time -fieldName "last_edited_time"
        }
        $notion_block.last_edited_by = [notion_user]::ConvertFromObject($Value.last_edited_by)
        $notion_block.archived = $Value.archived
        $notion_block.in_trash = $Value.in_trash
        $notion_block.has_children = $Value.has_children
        return $notion_block
    }
}
