class Synced_Block_structure
{
    [block] $synced_from = $null
    [block[]] $children = @()
    #TODO: Implement addchildren
    
    Synced_Block_structure()
    {
    }

    Synced_Block_structure([block] $synced_from)
    {
        $this.synced_from = $synced_from
    }
    static [Synced_Block_structure] ConvertFromObject($Value)
    {
        return [Synced_Block_structure]::new($Value.synced_from)
    }
}

class synced_block : block
# https://developers.notion.com/reference/block#synced-block
{
    [blocktype] $type = "synced_block"
    [Synced_Block_structure] $synced_block

    synced_block()
    {
        $this.synced_block = [Synced_Block_structure]::new()
    }

    static [synced_block] ConvertFromObject($Value)
    {
        return [Synced_Block_structure]::ConvertFromObject($Value.synced_block)
    }
}
