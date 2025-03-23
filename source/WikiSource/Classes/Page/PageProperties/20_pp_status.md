# PageProperty: Status

[API Reference](https://developers.notion.com/reference/page-property-values#status)

```mermaid
classDiagram
    class notion_status_page_property {
        [notion_status] $status
        ConvertFromObject()
    }
    `PagePropertiesBase` --|> `notion_status_page_property`:inherits
```

## Related Classes

- [PagePropertiesBase](./00_pp_base.md)
- [notion_status](../../General/20_status.md)
