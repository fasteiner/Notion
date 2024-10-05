class Block
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
    [bool]$archived
    [bool]$in_trash
    $has_children = $false

    
    Block()
    {
        #$this.id = [guid]::NewGuid().ToString()
    }
    # Block with array of children
    # [block]::new(@($block1,$block2))
    Block([array] $children)
    {
        #$this.id = [guid]::NewGuid().ToString()
        $this.children = $children
        if($children.count -gt 0)
        {
            $this.has_children = $true
        }
    }
    # Block with array of children and parent id
    # [block]::new(@($block1,$block2), $parent)
    Block([array] $children, [string] $parent)
    {
        #$this.id = [guid]::NewGuid().ToString()
        $this.children = $children
        $this.parent = @{
            "type"     = "block_id"
            "block_id" = $parent
        }
        if($children.count -gt 0)
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
}
