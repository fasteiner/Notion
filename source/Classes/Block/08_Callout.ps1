class callout_structure
{
    [blocktype] $type = "callout"
    [rich_text[]] $rich_text
    # icon: emoji or file
    $icon = [emoji]::new("")
    [notion_color] $color = "default"

    callout_structure()
    {
        $this.rich_text = @([rich_text]::new())
    }

    callout_structure([string] $text){
        $this.rich_text = @([rich_text_text]::new($text))
        $this.icon = [emoji]::new()
        $this.color = [notion_color]::default
    }

    callout_structure([rich_text[]] $rich_text, [string] $icon, [notion_color] $color = [notion_color]::default)
    {
        $this.rich_text = $rich_text.rich_text.ForEach({ [rich_text]::ConvertFromObject($_) })
        $this.icon = [emoji]::new($icon)
        $this.color = $color
    }

    callout_structure([rich_text[]] $rich_text, [emoji] $icon, [notion_color] $color = [notion_color]::default)
    {
        $this.rich_text = $rich_text.rich_text.ForEach({ [rich_text]::ConvertFromObject($_) })
        $this.icon = $icon
        $this.color = $color
    }

    callout_structure([string] $text, [emoji] $icon, [notion_color] $color = [notion_color]::default)
    {
        $this.rich_text = @([rich_text_text]::new($text))
        $this.icon = $icon
        $this.color = $color
    }

    static [callout_structure] ConvertFromObject($Value)
    {
        $callout_structure = [callout_structure]::new()
        $callout_structure.rich_text = $Value.rich_text.ForEach({ [rich_text]::ConvertFromObject($_) })
        switch ($Value.psobject.properties)
        {
            "emoji"
            {
                $callout_structure.icon = [emoji]::new($Value.icon.emoji.emoji) 
            }
            "file"
            {
                $callout_structure.icon = [notion_file]::new($Value.icon.external.url) 
            }
        }
        $callout_structure.color = [Enum]::Parse([notion_color], $Value.color)
        return $callout_structure
    }
}
class callout : Block
# https://developers.notion.com/reference/block#callout
{
    [blocktype] $type = "callout"
    [callout_structure] $callout

    callout()
    {
        $this.callout = [callout_structure]::new()
    }

    callout([rich_text[]] $rich_text, [string] $icon, [notion_color] $color)
    {
        $this.callout = [callout_structure]::new($rich_text, $icon, $color)
    }

    callout([rich_text[]] $rich_text, [emoji] $icon, [notion_color] $color)
    {
        $this.callout = [callout_structure]::new($rich_text, $icon, $color)
    }

    static [callout] ConvertFromObject($Value)
    {
        $calloutObj = [callout]::new()
        $calloutObj.callout = [callout_structure]::ConvertFromObject($Value.callout)
        return $calloutObj
    }
}
