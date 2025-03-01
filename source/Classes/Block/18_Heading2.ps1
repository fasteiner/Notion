class notion_heading_2_block : notion_heading_block
{
    [Heading_structure] $heading_2

    notion_heading_2_block() : base ("heading_2")
    {
        $this.heading_2 = [Heading_structure]::new()
    }

    notion_heading_2_block([Heading_structure] $heading_structure) : base("heading_2")
    {
        $this.heading_2 = $heading_structure
    }

    notion_heading_2_block([string] $text) : base("heading_2")
    {
        $this.heading_2 = [Heading_structure]::new($text)
    }

    notion_heading_2_block([string] $text, [notion_color] $color) : base("heading_2")
    {
        $this.heading_2 = [Heading_structure]::new($text, $color)
    }

    notion_heading_2_block([string] $text, [bool] $is_toggleable) : base("heading_2")
    {
        $this.heading_2 = [Heading_structure]::new($text, $is_toggleable)
    }

    notion_heading_2_block([string] $text, [notion_color] $color, [bool] $is_toggleable) : base("heading_2")
    {
        $this.heading_2 = [Heading_structure]::new($text, $color, $is_toggleable)
    }

    static [notion_heading_2_block] ConvertFromObject($Value)
    {
        $notion_heading_2_block = [notion_heading_2_block]::new([Heading_structure]::ConvertFromObject($Value.heading_2))
        return $notion_heading_2_block
    }
}
