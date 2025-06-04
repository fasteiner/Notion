class callout_structure
{
    [rich_text[]] $rich_text
    # icon: emoji or file
    [notion_emoji] $icon
    [notion_color] $color = "default"

    callout_structure()
    {
    }

    callout_structure([string] $text)
    {
        $this.rich_text = @([rich_text_text]::new($text))
        $this.color = [notion_color]::default
    }

    callout_structure($rich_text, $icon, $color = [notion_color]::default)
    {
        $this.rich_text = [rich_text]::ConvertFromObjects($rich_text)
        $this.icon = [notion_emoji]::ConvertFromObject($icon)
        $this.color = [Enum]::Parse([notion_color], $color)
    }

    static [callout_structure] ConvertFromObject($Value)
    {
        $callout_structure = [callout_structure]::new()
        $callout_structure.rich_text = $Value.rich_text.ForEach({ [rich_text]::ConvertFromObject($_) })
        switch ($Value.psobject.properties)
        {
            "emoji"
            {
                $callout_structure.icon = [notion_emoji]::new($Value.icon.emoji.emoji) 
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
class notion_callout_block : notion_block
# https://developers.notion.com/reference/block#callout
{
    [notion_blocktype] $type = "callout"
    [callout_structure] $callout

    notion_callout_block()
    {
        $this.callout = [callout_structure]::new()
    }

    notion_callout_block($rich_text, $icon, $color)
    {
        $this.callout = [callout_structure]::new($rich_text, $icon, $color)
    }


    static [notion_callout_block] ConvertFromObject($Value)
    {
        $callout_Obj = [notion_callout_block]::new()
        $callout_Obj.callout = [callout_structure]::ConvertFromObject($Value.callout)
        return $callout_Obj
    }
}
