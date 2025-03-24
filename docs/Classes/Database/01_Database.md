# Database

[API Reference](https://developers.notion.com/reference/database)

```mermaid
classDiagram
    class notion_database {
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
        ConvertFromObject()
    }
```

## Related Classes

- [notion_user](../User/01_user.md)
- [rich_text](../Block/RichText/01_Rich_Text.md)
- [notion_icon](../General/00_icon.md)
- [notion_file](../File/01_file.md)
- [notion_parent](../Parent/00_parent.md)
- [notion_databaseproperties](./DatabaseProperties/01_dp.md)
