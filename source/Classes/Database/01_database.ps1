class notion_database
# https://developers.notion.com/reference/database
{
    [string] $object = "database"
    [string] $id
    [string] $created_time
    [notion_user] $created_by
    [string] $last_edited_time
    [notion_user] $last_edited_by
    [rich_text[]] $title
    [rich_text[]] $description    
    [notion_icon] $icon
    [notion_file] $cover
    [notion_databaseproperties]$properties
    [notion_parent]$parent
    [string] $url
    [boolean] $archived
    [boolean] $in_trash
    [boolean] $is_inline
    [string] $public_url
    # Relation property (only mentioned in release notes, not in API docu)
    # [relation_type] $db_relation

    notion_database()
    {
        $this.created_time = [datetime]::UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
    }

    notion_database([rich_text[]]$title, [notion_parent]$parent, [notion_databaseproperties]$properties)
    {
        $this.created_time = [datetime]::UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
        $this.title = $title
        $this.parent = $parent
        $this.properties = $properties
    }

    notion_database([string]$title, [notion_parent]$parent, [notion_databaseproperties]$properties)
    {
        $this.created_time = [datetime]::UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
        $this.title = [rich_text_text]::new($title)
        $this.parent = $parent
        $this.properties = $properties
    }

    static [notion_database] ConvertFromObject($Value)
    {
        $database_obj = [notion_database]::new()
        $database_obj.id = $Value.id
        $database_obj.created_time = $Value.created_time
        $database_obj.created_by = [notion_user]::ConvertFromObject($Value.created_by)
        $database_obj.last_edited_time = $Value.last_edited_time
        $database_obj.last_edited_by = [notion_user]::ConvertFromObject($Value.last_edited_by)
        # is an array of rich_text objects, which does not make sense
        $database_obj.title = $value.title.foreach({[rich_text]::ConvertFromObject($_)})
        $database_obj.description = $value.description.foreach({[rich_text]::ConvertFromObject($_)})
        $database_obj.icon = [notion_icon]::ConvertFromObject($Value.icon)
        $database_obj.cover = [notion_file]::ConvertFromObject($Value.cover)
        $database_obj.properties = [notion_databaseproperties]::ConvertFromObject($Value.properties)
        $database_obj.parent = [notion_parent]::ConvertFromObject($Value.parent)
        $database_obj.url = $Value.url
        $database_obj.archived = $Value.archived
        $database_obj.in_trash = $Value.in_trash
        $database_obj.is_inline = $Value.is_inline
        $database_obj.public_url = $Value.public_url
        return $database_obj
    }
}
