class heading_2 : Heading
# https://developers.notion.com/reference/block#headings
{
    # Generates an empty heading_2 block
    heading_2() : base(2)
    {
    }

    # Generates a heading_2 block with content
    # [heading_2]::new("Hallo")
    heading_2([string] $content) : base(2, $content)
    {
    }

    # Generates a heading_2 block with content and toggleable option
    # [heading_2]::new("Hallo", $true)
    heading_2([string] $content, [bool] $is_toggleable) : base(2, $content, $is_toggleable)
    {
    }

    # Generates a heading_2 block with content class rich_text and toggleable
    # [heading_2]::new([rich_text]::new("Hallo"), $true)
    heading_2([rich_text] $content, [bool] $is_toggleable) : base(2, $content, $is_toggleable)
    {
    }
}
