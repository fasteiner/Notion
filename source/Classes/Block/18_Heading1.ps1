class Heading1 : Block
{
    [blocktype] $type = "heading_1"
    [rich_text[]] $rich_text
    [notion_color] $color = "default"
    [boolean] $is_toggleable
    #BUG children is not working
    #[block] $children = $null

    # Generates an empty heading1 block
    Heading1()
    {
        $this.is_toggleable = $false
    }
    # Generates a heading1 block with content "hallo"
    # [heading1]::new("Hallo")
    Heading1([string] $content)
    {
        $this.is_toggleable = $false
        $this.rich_text = @([rich_text]::new($content))
    }
    # Generates a heading1 block with content "hallo" and toggleable
    # [heading1]::new("Hallo",$true)
    Heading1([string] $content, [bool] $is_toggleable)
    {
        $this.is_toggleable = $is_toggleable
        addRichText($content)
    }
    # Generates a heading1 block with content class rich_text and toggleable
    # [heading1]::new([rich_text]::new("Hallo"),$true)
    Heading1([rich_text] $content, [bool] $is_toggleable)
    {
        $this.is_toggleable = $is_toggleable
        addRichText($content)
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
