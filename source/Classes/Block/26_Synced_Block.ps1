class synced_block : Block
# https://developers.notion.com/reference/block#synced-block
{
    [blocktype] $type = "synced_block"
    $synced_block = $null
    #[blocktype] $children = $null

    # static [synced_block] ConvertFromObject($Value)
    # {
    #     $synced_block = [synced_block]::new()
    #     $synced_block.synced_block = [block]::ConvertFromObject($Value.synced_block)
    #     return $synced_block
    # }
}
