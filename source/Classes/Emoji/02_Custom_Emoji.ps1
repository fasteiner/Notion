class custom_emoji_structure
{
    [string]$id
    [string]$name
    [string]$url

    custom_emoji_structure()
    {
        $this.id = $null
        $this.name = $null
        $this.url = $null
    }

    custom_emoji_structure($id, $name, $url)
    {
        $this.id = $id
        $this.name = $name
        $this.url = $url
    }

    static [custom_emoji_structure] ConvertFromObject($Value)
    {
        return [custom_emoji_structure]::new($Value.id, $Value.name, $Value.url)
    }

}   
class notion_custom_emoji
# https://developers.notion.com/reference/emoji-object#custom-emoji
{
    # needs to be string, as it is not contained in any enum
    [string]$type = "custom_emoji"
    [custom_emoji_structure]$custom_emoji

    notion_custom_emoji()
    {
        $this.custom_emoji = $null
    }

    notion_custom_emoji($custom_emoji)
    {
        $this.custom_emoji = [custom_emoji_structure]::ConvertFromObject($custom_emoji)
    }

    notion_custom_emoji($name, $url)
    {
        $this.custom_emoji = [custom_emoji_structure]::new($null, $name, $url)
    }

    notion_custom_emoji($id, $name, $url)
    {
        $this.custom_emoji = [custom_emoji_structure]::new($id, $name, $url)
    }

    static [notion_custom_emoji] ConvertFromObject($Value)
    {
        $custom_emojiObj = [notion_custom_emoji]::new()
        $custom_emojiObj.custom_emoji = [custom_emoji_structure]::ConvertFromObject($Value.custom_emoji)
        return $custom_emojiObj
    }
}
