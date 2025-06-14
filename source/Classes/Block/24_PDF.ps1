class PDF_structure : notion_file
{
    [rich_text[]] $caption
    
    PDF_structure($file)
    {
        $this.type = $file.type
        $this."$($file.type)" = $file
    }

    PDF_structure($caption, $file)
    {
        $this.caption = @($caption)
        $this.type = $file.type
        $this."$($file.type)" = $file
    }

    static [PDF_structure] ConvertFromObject($Value)
    {
        $pdf_obj = [notion_file]::ConvertFromObject($Value)
        $pdf_obj.caption = [rich_text]::ConvertFromObjects($Value.caption.rich_text)
        return $pdf_obj
    }
}


class notion_PDF_block : notion_block
# https://developers.notion.com/reference/block#pdf
{
    [notion_blocktype] $type = "pdf"
    [PDF_structure] $pdf
    
    notion_PDF_block()   
    {
        $this.pdf = [PDF_structure]::new()
        
    }

    notion_PDF_block($file)
    {
        $this.pdf = [PDF_structure]::new($file)
    }

    notion_PDF_block($caption, $file)
    {
        $this.pdf = [PDF_structure]::new($caption, $file)
    }
    # # Notion-hosted files constructor
    # PDF($url, $expiry_time, [rich_text[]] $caption) : base($url, $expiry_time)
    # {
    #     $this.caption = $caption
    # }

    # # External files constructor
    # PDF($url) : base($url)
    # {
    #     $this.caption = @()
    # }

    # # Generic constructor
    # PDF([notion_filetype] $filetype, $url, $expiry_time, [rich_text[]] $caption) : base($filetype, $url, $expiry_time)
    # {
    #     $this.caption = $caption
    # }

    static [notion_PDF_block] ConvertFromObject($Value)
    {
        $PDF_obj = [notion_PDF_block]::new()
        $PDF_obj.pdf = [PDF_structure]::ConvertFromObject($Value.pdf)
        return $PDF_obj
    }
}
