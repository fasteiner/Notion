class notion_block_file : Block
# https://developers.notion.com/reference/block#file
{
    [blocktype] $type = "file"
    [filetype] $file = $null
    [rich_text[]] $caption = $null
    
    static [notion_block_file] ConvertFromObject($Value)
    {
        $Block = [notion_block_file]::new()
        $Block.file = [filetype]::ConvertFromObject($Value.file)
        $Block.caption = $Value.caption | ForEach-Object { [rich_text]::ConvertFromObject($_) }
        return $Block
    }
}
