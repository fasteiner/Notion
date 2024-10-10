class Heading : Block
# https://developers.notion.com/reference/block#headings
{
    [int] $level
    [blocktype] $type
    [rich_text[]] $rich_text
    [notion_color] $color = "default"
    [boolean] $is_toggleable
    #BUG children is not working


    # Generates an empty heading block with a specified level
    Heading([int] $level)
    {
        $this.level = $level
        $this.type = "heading_$level"
        $this.is_toggleable = $false
    }

    # Generates a heading block with content and a specified level
    # [Heading]::new(1, "Hallo")
    Heading([int] $level, [string] $text)
    {
        $this.level = $level
        $this.type = "heading_$level"
        $this.is_toggleable = $false
        $this.addRichText($text)
    }

    # Generates a heading block with content and a toggleable option
    # [Heading]::new(1, "Hallo", $true)
    Heading([int] $level, [string] $text, [bool] $is_toggleable)
    {
        $this.level = $level
        $this.type = "heading_$level"
        $this.is_toggleable = $is_toggleable
        $this.addRichText($text)
    }

    # Generates a heading block with content class rich_text and toggleable
    # [Heading]::new(1, [rich_text]::new("Hallo"), $true)
    Heading([int] $level, [rich_text] $content, [bool] $is_toggleable)
    {
        $this.level = $level
        $this.type = "heading_$level"
        $this.is_toggleable = $is_toggleable
        $this.addRichText($content)
    }

    Heading([int] $level, [string] $text, [notion_color] $color)
    {
        $this.level = $level
        $this.type = "heading_$level"
        $this.is_toggleable = $false
        $this.color = $color
        $this.addRichText($text)
    }

    Heading([int] $level, [string] $text, [notion_color] $color, [bool] $is_toggleable)
    {
        $this.level = $level
        $this.type = "heading_$level"
        $this.is_toggleable = $is_toggleable
        $this.color = $color
        $this.addRichText($text)
    }

    [void] addRichText([rich_text] $richtext)
    {
        $this.rich_text += $richtext
    }

    [void] addRichText([string] $text)
    {
        $this.rich_text += [rich_text]::new($text)
    }

    static [Heading] ConvertFromObject($Value, $level)
    {
        $local:type = $Value.type
        $heading = [Heading]::new($level)
        $heading.rich_text = [rich_text]::ConvertFromObject($Value."$local:type".rich_text)
        $heading.color = [Enum]::Parse([notion_color], $Value.$local:type.color)
        $heading.is_toggleable = $Value.$local:type.is_toggleable
        return $heading
    }

    static [Heading] ConvertFromObject($Value)
    {
        return [Heading]::ConvertFromObject($Value, $Value.type.split("_")[1])
    }
}
