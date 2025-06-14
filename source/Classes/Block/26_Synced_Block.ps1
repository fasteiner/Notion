class Synced_Block_Duplicate_structure
{
    [string]$block_id = $null

    Synced_Block_Duplicate_structure()
    {
    }

    Synced_Block_Duplicate_structure($block_id)
    {
        $this.block_id = $block_id
    }
    static [Synced_Block_Duplicate_structure] ConvertFromObject($Value)
    {
        return [Synced_Block_Duplicate_structure]::new($Value.block_id)
    }
}


class Synced_Block_structure
{
    [Synced_Block_Duplicate_structure] $synced_from = $null
    [notion_block[]] $children = @()
    #TODO: Implement addchildren
    
    Synced_Block_structure()
    {
    }

    Synced_Block_structure($synced_from)
    {
        $this.synced_from = [Synced_Block_Duplicate_structure]::new($synced_from.block_id)
    }

    [void] AddChild( $child)
    {
        if ($this.synced_from -eq $null)
        {
            $this.children += [notion_block]::ConvertFromObject($child)
        }
        else
        {
            Write-Error "Cannot add child to synced block, as this is a duplicate synced block." -Category InvalidOperation -TargetObject $this
            return
        }
    }

    [void] AddChildren( $children)
    {
        foreach ($child in $children)
        {
            $this.AddChild($child)
        }
    }


    static [Synced_Block_structure] ConvertFromObject($Value)
    {
        if ($Value.synced_from)
        {
            if ($Value.synced_from.object -is [Synced_Block_structure])
            {
                return $Value.synced_from
            }
            $synced_from_Obj = [Synced_Block_structure]::new()
            $synced_from_Obj.synced_from = [Synced_Block_Duplicate_structure]::ConvertFromObject($Value.synced_from)
            return $synced_from_Obj
        }
        else
        {
            return [Synced_Block_structure]::new()
        }
    }
}

class notion_synced_block : notion_block
# https://developers.notion.com/reference/block#synced-block
{
    [notion_blocktype] $type = "synced_block"
    [Synced_Block_structure] $synced_block


    #Original synced block constructor
    notion_synced_block()
    {
        $this.synced_block = [Synced_Block_structure]::new()
    }

    #duplicate synced block constructor
    notion_synced_block($synced_block)
    {
        $this.synced_block = [Synced_Block_structure]::new($synced_block)
    }

    [void] AddChild( $child)
    {
        $this.synced_block.AddChild($child)
    }

    [void] AddChildren( $children)
    {
        foreach ($child in $children)
        {
            $this.AddChild($child)
        }
    }

    static [notion_synced_block] ConvertFromObject($Value)
    {
        $synced_block_Obj = [notion_synced_block]::new()
        $synced_block_Obj.synced_block = [Synced_Block_structure]::ConvertFromObject($Value.synced_block)
        return $synced_block_Obj
    }
}
