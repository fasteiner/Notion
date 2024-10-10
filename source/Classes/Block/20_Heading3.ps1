class Heading3 : Heading
# https://developers.notion.com/reference/block#headings
{
    # Generates an empty heading3 block
    Heading3() : base(3)
    {
    }

    # Generates a heading3 block with content
    # [Heading3]::new("Hallo")
    Heading3([string] $content) : base(3, $content)
    {
    }

    # Generates a heading3 block with content and toggleable option
    # [Heading3]::new("Hallo", $true)
    Heading3([string] $content, [bool] $is_toggleable) : base(3, $content, $is_toggleable)
    {
    }

    # Generates a heading3 block with content class rich_text and toggleable
    # [Heading3]::new([rich_text]::new("Hallo"), $true)
    Heading3([rich_text] $content, [bool] $is_toggleable) : base(3, $content, $is_toggleable)
    {
    }
}
