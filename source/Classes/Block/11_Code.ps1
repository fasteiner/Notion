class Code : Block
# https://developers.notion.com/reference/block#code
{
    #TODO: definition correct? 
    [blocktype] $type = "code"
    [rich_text[]] $caption
    [rich_text[]] $rich_text
    [notion_language] $language = $null

    code ($Code)
    {
        $this.caption = [rich_text_content]::new($Code.caption)
        $this.rich_text = [rich_text_content]::new($Code.rich_text)
        switch ($Code.language)
        {
            "csharp"
            {
                $this.language = "c#"; return 
            }
            "cpp"
            {
                $this.language = "c++" ; return
            }
            "objective_c"
            {
                $this.language = "objective-c"; return 
            }
            "java_c_cplusplus_csharp"
            {
                $this.language = "java/c/c++/c#"; return 
            }
            "vb_net"
            {
                $this.language = "vb.net"; return 
            }
            default
            {
                $this.language = $Code.language 
            }
        }
    }
}
