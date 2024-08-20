class Heading1 : Heading
{
    # Generates an empty heading1 block
    Heading1() : base(1)
    {
    }

    # Generates a heading1 block with content
    # [Heading1]::new("Hallo")
    Heading1([string] $content) : base(1, $content)
    {
    }

    # Generates a heading1 block with content and toggleable option
    # [Heading1]::new("Hallo", $true)
    Heading1([string] $content, [bool] $is_toggleable) : base(1, $content, $is_toggleable)
    {
    }

    # Generates a heading1 block with content class rich_text and toggleable
    # [Heading1]::new([rich_text]::new("Hallo"), $true)
    Heading1([rich_text] $content, [bool] $is_toggleable) : base(1, $content, $is_toggleable)
    {
    }
}
