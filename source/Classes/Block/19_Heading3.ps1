class notion_heading_3_block : notion_heading_block
{
    [Heading_structure] $heading_3

    notion_heading_3_block() : base ("heading_3")
    {
        $this.heading_3 = [Heading_structure]::new()
    }

    notion_heading_3_block([Heading_structure] $heading_structure) : base("heading_3")
    {
        $this.heading_3 = $heading_structure
    }

    notion_heading_3_block([string] $text) : base("heading_3")
    {
        $this.heading_3 = [Heading_structure]::new($text)
    }

    notion_heading_3_block([string] $text, [notion_color] $color) : base("heading_3")
    {
        $this.heading_3 = [Heading_structure]::new($text, $color)
    }

    notion_heading_3_block([string] $text, [bool] $is_toggleable) : base("heading_3")
    {
        $this.heading_3 = [Heading_structure]::new($text, $is_toggleable)
    }

    notion_heading_3_block([string] $text, [notion_color] $color, [bool] $is_toggleable) : base("heading_3")
    {
        $this.heading_3 = [Heading_structure]::new($text, $color, $is_toggleable)
    }

    static [notion_heading_3_block] ConvertFromObject($Value)
    {
        $notion_heading_3_block = [notion_heading_3_block]::new([Heading_structure]::ConvertFromObject($Value.heading_3))
        return $notion_heading_3_block
    }
}
