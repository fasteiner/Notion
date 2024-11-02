

class link_preview 
# https://developers.notion.com/reference/block#link-preview
{
    [blocktype] $type = "link_preview"
    [link_preview_structure] $link_preview

    link_preview() { }

    static [link_preview] ConvertFromObject ($value)
    {
        $link_preview_obj = @{}
        $link_preview_obj.type = "link_preview"
        $link_preview_obj.url = $value.url
        return $link_preview_obj
    }

}
