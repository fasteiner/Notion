class bookmark_structure
{
    [notion_blocktype] $type = "bookmark"
    [rich_text[]] $caption = @()
    [string] $url = $null

    bookmark_structure([string] $url)
    {
        $this.url = $url
    }
    
    
    bookmark_structure([object]$bookmark)
    {
        $this.caption = $bookmark.caption
        $this.url = $bookmark.url
    }


    bookmark_structure([rich_text[]]$caption, [string]$url)
    {
        $this.caption = $caption
        $this.url = $url
    }

    bookmark_structure([string]$caption, [string]$url)
    {
        $this.caption = @([rich_text_text]::new($caption))
        $this.url = $url
    }
}


class notion_bookmark_block : notion_block
# https://developers.notion.com/reference/block#bookmark
{
    [notion_blocktype] $type = "bookmark"
    [bookmark_structure] $bookmark
    

    notion_bookmark_block([string]$url)
    {
        $this.bookmark = [bookmark_structure]::new($url)
    }
    
    notion_bookmark_block([bookmark_structure]$bookmark)
    {
        $this.bookmark = [bookmark_structure]::new($bookmark)
    }
    
    notion_bookmark_block([rich_text[]]$caption, [string]$url)
    {
        $this.bookmark = [bookmark_structure]::new($caption, $url)
    }

    notion_bookmark_block([string]$caption, [string]$url)
    {
        $this.bookmark = [bookmark_structure]::new($caption, $url)
    }


    static [notion_bookmark_block] ConvertFromObject($Value)
    {
        $bookmark_Obj = [notion_bookmark_block]::new()
        $bookmark_Obj.bookmark = [bookmark_structure]::new($Value.bookmark)
        return $bookmark_Obj
    }
}
