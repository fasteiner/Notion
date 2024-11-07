class bookmark_structure
{
    [blocktype] $type = "bookmark"
    [rich_text[]] $caption = @()
    [string] $url = $null

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


class bookmark : Block
# https://developers.notion.com/reference/block#bookmark
{
    [blocktype] $type = "bookmark"
    [bookmark_structure] $bookmark
    

    bookmark()
    {
    }

    bookmark([bookmark_structure]$bookmark)
    {
        $this.bookmark = [bookmark_structure]::new($bookmark)
    }
    
    bookmark_structure([rich_text[]]$caption, [string]$url)
    {
        $this.bookmark = [bookmark_structure]::new($caption, $url)
    }

    bookmark_structure([string]$caption, [string]$url)
    {
        $this.bookmark = [bookmark_structure]::new($caption, $url)
    }


    static [bookmark] ConvertFromObject($Value)
    {
        $bookmarkObj = [bookmark]::new()
        $bookmarkObj.bookmark = [bookmark_structure]::new($Value.bookmark)
        return $bookmarkObj
    }
}
