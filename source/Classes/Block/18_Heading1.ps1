class heading_1 : Heading
# https://developers.notion.com/reference/block#headings
{
    # Generates an empty heading_1 block
    heading_1() : base(1)
    {
    }

    # Generates a heading_1 block with content
    # [heading_1]::new("Hallo")
    heading_1([string] $text) : base(1, [string]$text)
    {
    }

    # Generates a heading_1 block with content and toggleable option
    # [heading_1]::new("Hallo", $true)
    heading_1([string] $text, [bool] $is_toggleable) : base(1, $text, $is_toggleable)
    {
    }

    # Generates a heading_1 block with content class rich_text and toggleable
    # [heading_1]::new([rich_text]::new("Hallo"), $true)
    heading_1([rich_text] $content, [bool] $is_toggleable) : base(1, $content, $is_toggleable)
    {
    }
}
