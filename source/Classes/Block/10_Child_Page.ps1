class child_page_structure
{
    [string] $title = $null

    child_page_structure()
    {

    }

    child_page_structure([string] $title)
    {
        $this.title = $title
    }

    static [child_page_structure] ConvertFromObject($Value)
    {
        $child_page_structure = [child_page]::new()
        $child_page_structure.title = $Value.title
        return $child_page_structure
    }
}
class child_page : block
# https://developers.notion.com/reference/block#child-page
{
    [blocktype] $type = "child_page"
    [child_page_structure] $child_page


    child_page(){
        $this.child_page = [child_page_structure]::new()
    }

    child_page([string] $title){
        $this.child_page = [child_page_structure]::new($title)
    }

    static [child_page] ConvertFromObject($Value)
    {
        return [child_page_structure]::ConvertFromObject($Value.child_page)
    }
}
