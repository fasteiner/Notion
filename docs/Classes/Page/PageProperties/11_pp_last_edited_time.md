# PageProperty: Last_edited_time

[API Reference](https://developers.notion.com/reference/page-property-values#last-edited-time)

```mermaid
classDiagram
    class notion_last_edited_time_page_property {
        [string] $last_edited_time
        ConvertFromObject()
    }
    `PagePropertiesBase` --|> `notion_last_edited_time_page_property`:inherits
```

## Remarks

The internal function `ConvertTo-NotionFormattedDateTime` is used to validate the input and convert it to a Notion-formatted DateTime string.

## Related Classes

- [PagePropertiesBase](./00_pp_base.md)
