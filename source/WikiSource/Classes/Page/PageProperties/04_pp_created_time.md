# PageProperty: Created_time

[API Reference](https://developers.notion.com/reference/page-property-values#created-time)

```mermaid
classDiagram
    class notion_created_time_page_property {
        [string] $created_time
        ConvertFromObject()
    }
    `PagePropertiesBase` --|> `notion_created_time_page_property`:inherits
```

## Remarks

The internal function `ConvertTo-NotionFormattedDateTime` is used to validate the input and convert it to a Notion-formatted DateTime string.

## Related Classes

- [PagePropertiesBase](./00_pp_base.md)
