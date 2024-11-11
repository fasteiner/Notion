class heading_3 : Heading
# https://developers.notion.com/reference/block#headings
{
    # Generates an empty heading_3 block
    heading_3() : base(3)
    {
    }

    # Generates a heading_3 block with content
    # [heading_3]::new("Hallo")
    heading_3([string] $content) : base(3, $content)
    {
    }

    # Generates a heading_3 block with content and toggleable option
    # [heading_3]::new("Hallo", $true)
    heading_3([string] $content, [bool] $is_toggleable) : base(3, $content, $is_toggleable)
    {
    }

    # Generates a heading_3 block with content class rich_text and toggleable
    # [heading_3]::new([rich_text]::new("Hallo"), $true)
    heading_3([rich_text] $content, [bool] $is_toggleable) : base(3, $content, $is_toggleable)
    {
    }
}
