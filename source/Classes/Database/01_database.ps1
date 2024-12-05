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
    $icon
    $cover
    $properties
    $parent
    [string] $url
    [boolean] $archived
    [boolean] $in_trash
    [boolean] $is_inline
    [string] $public_url
    # Relation property (only mentioned in release notes, not in API docu)
    # [relation_type] $db_relation

    notion_database()
    {
        $this.id = [guid]::NewGuid().ToString()
        $this.created_time = [datetime]::UtcNow.ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
    }
}
