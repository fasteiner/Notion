class notion_block_parent : notion_parent{
    [string] $block_id

    notion_block_parent() : base("block_id")
    {
    }

    notion_block_parent([string]$block_id) : base("block_id")
    {
        $this.block_id = $block_id
    }

    static [notion_block_parent] ConvertFromObject($Value)
    {
        return [notion_block_parent]::new($Value.block_id)
    }
}
