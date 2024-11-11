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
class custom_emoji
# https://developers.notion.com/reference/emoji-object#custom-emoji
{
    [icontype]$type = "custom_emoji"
    [string]$custom_emoji

    custom_emoji()
    {
        $this.custom_emoji = $null
    }

    custom_emoji([custom_emoji]$custom_emoji)
    {
        $this.custom_emoji = $custom_emoji
    }

    static [custom_emoji] ConvertFromObject($Value)
    {
        $custom_emojiObj = [custom_emoji]::new()
        $custom_emojiObj.custom_emoji = [custom_emoji_structure]::ConvertFromObject($Value.custom_emoji)
        return $custom_emojiObj
    }
}
