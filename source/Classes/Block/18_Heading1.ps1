class Heading1 : Heading
# https://developers.notion.com/reference/block#headings
{
    # Generates an empty heading1 block
    Heading1() : base(1)
    {
    }

    # Generates a heading1 block with content
    # [Heading1]::new("Hallo")
    Heading1([string] $text) : base(1, [string]$text)
    {
    }

    # Generates a heading1 block with content and toggleable option
    # [Heading1]::new("Hallo", $true)
    Heading1([string] $text, [bool] $is_toggleable) : base(1, $text, $is_toggleable)
    {
    }

    # Generates a heading1 block with content class rich_text and toggleable
    # [Heading1]::new([rich_text]::new("Hallo"), $true)
    Heading1([rich_text] $content, [bool] $is_toggleable) : base(1, $content, $is_toggleable)
    {
    }
}
