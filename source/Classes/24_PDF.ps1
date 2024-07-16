class PDF : Block
{
    [blocktype] $type = "pdf"
    [rich_text[]] $caption = $null
    $pdf = @{
        "type"     = "external"
        "external" = @{
            "url" = $null
        }
    }
}
