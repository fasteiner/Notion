# PageProperty: Last_edited_by

[API Reference](https://developers.notion.com/reference/page-property-values#last-edited-by)

```mermaid
classDiagram
    class notion_last_edited_by_page_property {
        [notion_user] $last_edited_by
        ConvertFromObject()
    }
    `PagePropertiesBase` --|> `notion_last_edited_by_page_property`:inherits
```

## Related Classes

- [PagePropertiesBase](./00_pp_base.md)
- [notion_user](../../User/01_user.md)
