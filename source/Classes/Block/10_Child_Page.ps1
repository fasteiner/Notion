class child_page : Block
# https://developers.notion.com/reference/block#child-page
{
    [blocktype] $type = "child_page"
    [string] $title = $null


    child_page(){

    }

    child_page([string] $title){
        $this.title = $title
    }

    static [child_page] ConvertFromObject($Value)
    {
        $child_page = [child_page]::new()
        $child_page.title = $Value.title
        return $child_page
    }
}
