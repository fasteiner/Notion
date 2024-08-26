class Callout : Block
{
    [blocktype] $type = "callout"
    [rich_text[]] $rich_text
    # icon: emoji or file
    $icon = [emoji]::new("")
    [notion_color] $color = "default"

    static ConvertFromObject($Value)
    {
        $callout = [Callout]::new()
        $callout.rich_text = @()
        foreach ($rich_text in $Value.rich_text)
        {
            $callout.rich_text += [rich_text]::ConvertFromObject($rich_text)
        }
        switch ($.Value.psobject.properties) {
            "emoji" { $callout.icon = [emoji]::new($Value.icon.emoji.emoji) }
            "file" {  $callout.icon = [notion_file]::new($Value.icon.external.url) }
        }
        $callout.color = [notion_color]::ConvertFromObject($Value.color)
    }
}
