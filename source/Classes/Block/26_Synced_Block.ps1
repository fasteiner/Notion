class Synced_Block_structure
{
    [notion_block] $synced_from = $null
    [notion_block[]] $children = @()
    #TODO: Implement addchildren
    
    Synced_Block_structure()
    {
    }

    Synced_Block_structure([notion_block] $synced_from)
    {
        $this.synced_from = $synced_from
    }
    static [Synced_Block_structure] ConvertFromObject($Value)
    {
        return [Synced_Block_structure]::new($Value.synced_from)
    }
}

class notion_synced_block : notion_block
# https://developers.notion.com/reference/block#synced-block
{
    [notion_blocktype] $type = "synced_block"
    [Synced_Block_structure] $synced_block

    notion_synced_block()
    {
        $this.synced_block = [Synced_Block_structure]::new()
    }

    static [notion_synced_block] ConvertFromObject($Value)
    {
        $synced_block_Obj = [notion_synced_block]::new()
        $synced_block_Obj.synced_block = [Synced_Block_structure]::ConvertFromObject($Value.synced_block)
        return $synced_block_Obj
    }
}
