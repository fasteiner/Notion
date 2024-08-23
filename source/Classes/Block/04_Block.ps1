class Block
{
    #$object = "block"
    #$id = $null
    # $parent = @{
    #     "type"     = "block_id"
    #     "block_id" = $null
    # }
    #$after = ""
    $children = @()
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
