class notion_PDF_block : notion_block
# https://developers.notion.com/reference/block#pdf
{
    [notion_blocktype] $type = "pdf"
    [notion_file] $pdf
    
    notion_PDF_block()   
    {      

    }

    notion_PDF_block($file)
    {
        $this.pdf = [notion_file]::ConvertFromObject($file)
    }

    notion_PDF_block($caption, $url, $name)
    {
        $this.pdf = [notion_file]::Create("external", $name, $caption, $url, $null)
    }
    
    static [notion_PDF_block] ConvertFromObject($Value)
    {
        $PDF_obj = [notion_PDF_block]::new()
        $PDF_obj.pdf = [notion_file]::ConvertFromObject($Value.pdf)
        return $PDF_obj
    }
}
