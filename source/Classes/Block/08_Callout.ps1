class Callout : Block
# https://developers.notion.com/reference/block#callout
{
    [blocktype] $type = "callout"
    [rich_text[]] $rich_text
    # icon: emoji or file
    $icon = [emoji]::new("")
    [notion_color] $color = "default"

    static [Callout] ConvertFromObject($Value)
    {
        $callout = [Callout]::new()
        $callout.rich_text = $Value.rich_text.ForEach({[rich_text]::ConvertFromObject($_)})
        switch ($Value.psobject.properties) {
            "emoji" { $callout.icon = [emoji]::new($Value.icon.emoji.emoji) }
            "file" {  $callout.icon = [notion_file]::new($Value.icon.external.url) }
        }
        $callout.color = [Enum]::Parse([notion_color], $Value.color)
        return $callout
    }
}
