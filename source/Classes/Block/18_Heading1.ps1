class notion_heading_1_block : notion_heading_block
{
    [Heading_structure] $heading_1

    notion_heading_1_block() : base ("heading_1")
    {
        $this.heading_1 = [Heading_structure]::new()
    }

    notion_heading_1_block([Heading_structure] $heading_structure) : base("heading_1")
    {
        $this.heading_1 = $heading_structure
    }

    notion_heading_1_block([string] $text) : base("heading_1")
    {
        $this.heading_1 = [Heading_structure]::new($text)
    }

    notion_heading_1_block([string] $text, [notion_color] $color) : base("heading_1")
    {
        $this.heading_1 = [Heading_structure]::new($text, $color)
    }

    notion_heading_1_block([string] $text, [bool] $is_toggleable) : base("heading_1")
    {
        $this.heading_1 = [Heading_structure]::new($text, $is_toggleable)
    }

    notion_heading_1_block([string] $text, [notion_color] $color, [bool] $is_toggleable) : base("heading_1")
    {
        $this.heading_1 = [Heading_structure]::new($text, $color, $is_toggleable)
    }


    static [notion_heading_1_block] ConvertFromObject($Value)
    {
        $notion_heading_1_block = [notion_heading_1_block]::new([Heading_structure]::ConvertFromObject($Value.heading_1))
        return $notion_heading_1_block
    }
}
