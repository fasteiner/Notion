class PDF_structure
{
    [rich_text[]] $caption
    [notion_filetype] $type
    
    PDF_structure([notion_file] $file)
    {
        $this.type = $file.type
        $this."$($file.type)" = $file
    }

    PDF_structure([rich_text[]] $caption, [notion_filetype] $file)
    {
        $this.caption = @($caption)
        $this.type = $file.type
        $this."$($file.type)" = $file
    }

    static [PDF_structure] ConvertFromObject($Value)
    {
        return [PDF_structure]::new($Value.caption, $Value.pdf)
    }

}
class PDF : notion_file
# https://developers.notion.com/reference/block#pdf
{
    [blocktype] $type = "pdf"
    [PDF_structure] $pdf
    
    PDF()   
    {
        $this.pdf = [PDF_structure]::new()
        
    }

    PDF([notion_file] $file)
    {
        $this.pdf = [PDF_structure]::new($file)
    }

    PDF([rich_text[]] $caption, [notion_file] $file)
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

    static [PDF] ConvertFromObject($Value)
    {
        return [PDF_structure]::ConvertFromObject($Value.pdf)
    }
}
