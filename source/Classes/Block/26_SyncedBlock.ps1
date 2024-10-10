class SyncedBlock : Block
# https://developers.notion.com/reference/block#synced-block
{
    [blocktype] $type = "synced_block"
    $synced_block = $null
    #[blocktype] $children = $null

    # static [SyncedBlock] ConvertFromObject($Value)
    # {
    #     $SyncedBlock = [SyncedBlock]::new()
    #     $SyncedBlock.synced_block = [block]::ConvertFromObject($Value.synced_block)
    #     return $SyncedBlock
    # }
}
