class link_preview_structure
{
    [string] $url

    link_preview_structure()
    {
    }

    link_preview_structure($url)
    {
        $this.url = $url
    }

    static [link_preview_structure] ConvertFromObject($value)
    {
        return [link_preview_structure]::new($value.url)
    }
}

class notion_link_preview_block : notion_block
# https://developers.notion.com/reference/block#link-preview
{
    [notion_blocktype] $type = "link_preview"
    [link_preview_structure] $link_preview

    notion_link_preview_block()
    { 
    }

    notion_link_preview_block($url)
    {
        $this.link_preview = [link_preview_structure]::new($url)
    }

    static [notion_link_preview_block] ConvertFromObject ($value)
    {
        $link_preview_obj = [notion_link_preview_block]::new()
        $link_preview_obj.link_preview = [link_preview_structure]::ConvertFromObject($value.link_preview)
        return $link_preview_obj
    }

}
