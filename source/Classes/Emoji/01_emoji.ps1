class emoji
# https://developers.notion.com/reference/emoji-object
{
    [icontype]$type = "emoji"
    [string]$emoji

    emoji()
    {
        $this.emoji = $null
    }

    emoji($emoji)
    {
        $this.emoji = $emoji
    }

    static [emoji] ConvertFromObject($Value)
    {
        return [emoji]::new($Value.emoji)
    }
}
