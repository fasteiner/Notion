class rich_type_mention : rich_text
# https://developers.notion.com/reference/rich-text#mention
{
    [rich_text_mention_type] $mention
    #TODO: database, data, link_preview, page, template_mention, user

    rich_type_mention()
    {
    }
    rich_type_mention([rich_text_mention_type] $type, [rich_text[]] $rich_text, [notion_color] $color)
    {
        $this.mention = $mention
        $this.rich_text = $rich_text
        $this.color = $color
    }

    static [rich_type_mention] ConvertFromObject($Value)
    {
        $rich_type_mention = [rich_type_mention]::new()
        $rich_type_mention.mention = $Value.mention
        $rich_type_mention.rich_text = [rich_text]::ConvertFromObject($Value.rich_text)
        $rich_type_mention.color = [Enum]::Parse([notion_color], $Value.color)
        return $rich_type_mention
    }
}
