class Heading3 : Block
{
    [blocktype] $type = "heading_3"
    [rich_text[]] $rich_text
    [color] $color = "default"
    [boolean] $is_toggleable
    #BUG children is not working
    #[block] $children = $null

    Heading3 ()
    {

    }
    Heading3([string] $text)
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
