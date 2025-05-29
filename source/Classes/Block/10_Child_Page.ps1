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
        $child_page_structure = [child_page_structure]::new()
        $child_page_structure.title = $Value.title
        return $child_page_structure
    }
}
class notion_child_page_block : notion_block
# https://developers.notion.com/reference/block#child-page
{
    [notion_blocktype] $type = "child_page"
    [child_page_structure] $child_page


    notion_child_page_block()
    {
        $this.child_page = [child_page_structure]::new()
    }

    notion_child_page_block([string] $title)
    {
        $this.child_page = [child_page_structure]::new($title)
    }

    static [notion_child_page_block] ConvertFromObject($Value)
    {
        $child_page_Obj = [notion_child_page_block]::new()
        $child_page_Obj.child_page = [child_page_structure]::ConvertFromObject($Value.child_page)
        return $child_page_Obj
    }
}
