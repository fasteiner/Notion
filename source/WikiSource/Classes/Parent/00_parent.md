# Parent

[API Reference](https://developers.notion.com/reference/parent-object)

```mermaid
classDiagram
    class notion_parent {
        [notion_parent_type]$type
        ConvertfromObject()
    }
    `notion_parent` --|> `notion_database_parent`:inherits
    `notion_parent` --|> `notion_page_parent`:inherits
    `notion_parent` --|> `notion_workspace_parent`:inherits
    `notion_parent` --|> `notion_block_parent`:inherits
```

## Child classes

- [notion_database_parent](./01_database_parent.md)
- [notion_page_parent](./02_page_parent.md)
- [notion_workspace_parent](./03_workspace_parent.md)
- [notion_block_parent](./04_block_parent.md)
