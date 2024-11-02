class PDF : notion_file
# https://developers.notion.com/reference/block#pdf
{
    [blocktype] $type = "pdf"
    [rich_text[]] $caption
    
    PDF()   
    {
        $this.caption = @()
        
    }
    # Notion-hosted files constructor
    PDF($url, $expiry_time, [rich_text[]] $caption) : base($url, $expiry_time)
    {
        $this.caption = $caption
    }

    # External files constructor
        PDF($url) : base($url)
    {
        $this.caption = @()
    }

    # Generic constructor
    PDF([notion_filetype] $filetype, $url, $expiry_time, [rich_text[]] $caption) : base($filetype, $url, $expiry_time)
    {
        $this.caption = $caption
    }


    # static [PDF] ConvertFromObject($Value)
    # {
    #     $Block = [PDF]::new()
    #     $Block.pdf.external.url = $Value.url
    #     $Block.caption = $Value.caption | ForEach-Object { [rich_text]::ConvertFromObject($_) }
    #     return $Block
    # }
}
