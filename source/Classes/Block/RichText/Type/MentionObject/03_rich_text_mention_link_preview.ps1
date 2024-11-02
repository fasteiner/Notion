class rich_text_mention_link_preview_structure
{
    [string] $url


    rich_text_mention_link_preview_structure()
    {
    }
    rich_text_mention_link_preview_structure($url)
    {
        $this.url = $url
    }

    static [rich_text_mention_link_preview_structure] ConvertFromObject($value)
    {
        return [rich_text_mention_link_preview_structure]::new($value.url)
    }
}


class rich_text_mention_link_preview : rich_text_mention_base
# https://developers.notion.com/reference/rich-text#mention
{
    [rich_text_mention_type] $type = "link_preview"
    [rich_text_mention_link_preview_structure] $link_preview
    

    rich_text_mention_link_preview() :base("link_preview")
    {
    }

    rich_text_mention_link_preview([rich_text_mention_link_preview_structure] $link_preview) :base("link_preview")
    {
        $this.link_preview = $link_preview
    }

    rich_text_mention_link_preview([string] $url) :base("link_preview")
    {
        $this.link_preview = [rich_text_mention_link_preview_structure]::new($url)
    }

    static [rich_text_mention_link_preview] ConvertFromObject($value)
    {
        return [rich_text_mention_link_preview]::new($value.link_preview)
    }
}
