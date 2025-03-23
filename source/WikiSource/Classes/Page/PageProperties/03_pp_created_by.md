# PageProperty: Created_by

[API Reference](https://developers.notion.com/reference/page-property-values#created-by)

```mermaid
classDiagram
    class notion_created_by_page_property {
        [notion_user] $created_by
        ConvertFromObject()
    }
    `PagePropertiesBase` --|> `notion_created_by_page_property`:inherits
```

## Related Classes

- [notion_user](../../User/01_user.md)
- [PagePropertiesBase](./00_pp_base.md)
