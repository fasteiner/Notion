class Heading : Block
{
    [int] $level
    [blocktype] $type
    [rich_text[]] $rich_text
    [notion_color] $color = "default"
    [boolean] $is_toggleable
    #BUG children is not working
    #[block] $children = $null

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
}
