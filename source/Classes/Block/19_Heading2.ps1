class Heading2 : Block
{
    [blocktype] $type = "heading_2"
    [rich_text[]] $rich_text
    [color] $color = "default"
    [boolean] $is_toggleable
    #BUG children is not working
    #[block] $children = $null

    Heading2 ()
    {

    }
    Heading2([string] $text)
    {
        $rt = [rich_text]::new($text)
        $this.addRichText($rt)
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
