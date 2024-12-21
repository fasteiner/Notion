class notion_emoji : notion_icon
# https://developers.notion.com/reference/notion_emoji-object
{
    [icontype]$type = "emoji"
    [string]$emoji

    notion_emoji()
    {
        $this.emoji = $null
    }

    notion_emoji($emoji)
    {
        $this.emoji = $emoji
    }

    static [notion_emoji] ConvertFromObject($Value)
    {
        return [notion_emoji]::new($Value.emoji)
    }
}
