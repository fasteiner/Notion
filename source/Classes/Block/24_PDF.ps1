class PDF : Block
# https://developers.notion.com/reference/block#pdf
{
    [blocktype] $type = "pdf"
    [rich_text[]] $caption = $null
    $pdf = @{
        "type"     = "external"
        "external" = @{
            "url" = $null
        }
    }

    # static [PDF] ConvertFromObject($Value)
    # {
    #     $Block = [PDF]::new()
    #     $Block.pdf.external.url = $Value.url
    #     $Block.caption = $Value.caption | ForEach-Object { [rich_text]::ConvertFromObject($_) }
    #     return $Block
    # }
}
