class Heading2 : Heading
# https://developers.notion.com/reference/block#headings
{
    # Generates an empty heading2 block
    Heading2() : base(2)
    {
    }

    # Generates a heading2 block with content
    # [Heading2]::new("Hallo")
    Heading2([string] $content) : base(2, $content)
    {
    }

    # Generates a heading2 block with content and toggleable option
    # [Heading2]::new("Hallo", $true)
    Heading2([string] $content, [bool] $is_toggleable) : base(2, $content, $is_toggleable)
    {
    }

    # Generates a heading2 block with content class rich_text and toggleable
    # [Heading2]::new([rich_text]::new("Hallo"), $true)
    Heading2([rich_text] $content, [bool] $is_toggleable) : base(2, $content, $is_toggleable)
    {
    }
}
