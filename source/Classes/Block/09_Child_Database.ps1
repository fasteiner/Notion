class child_database_structure
{
    [string] $title = $null
    
    child_database_structure()
    {
    }

    child_database_structure([string] $title)
    {
        $this.title = $title
    }

    static [child_database_structure] ConvertFromObject($Value)
    {
        $child_database_structure = [child_database_structure]::new()
        $child_database_structure.title = $Value.title
        return $child_database_structure
    }
}
class notion_child_database_block : notion_block
# https://developers.notion.com/reference/block#child-database
{
    [notion_blocktype] $type = "child_database"
    [child_database_structure] $child_database


    #TODO: Creating and updating child_database blocks
    #TODO: To create or update child_database type blocks, use the Create a database and the Update a database endpoints, specifying the ID of the parent page in the parent body param.
    notion_child_database_block()
    {
        $this.child_database = [child_database_structure]::new()
    }

    notion_child_database_block([string] $title)
    {
        $this.child_database = [child_database_structure]::new($title)
    }

    static [notion_child_database_block] ConvertFromObject($Value)
    {
        $child_database_Obj = [notion_child_database_block]::new()
        $child_database_Obj.child_database = [child_database_structure]::new($Value.child_database)
        return $child_database_Obj
    }
}
