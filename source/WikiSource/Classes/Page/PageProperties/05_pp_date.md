# PageProperty: Date

[API Reference](https://developers.notion.com/reference/page-property-values#date)

```mermaid
classDiagram
    class notion_date_page_property_structure {
        [string] $end
        [string] $start
        ConvertFromObject()
    }
    class notion_date_page_property {
        [notion_date_page_property_structure] $date
        ConvertFromObject()
    }
    `PagePropertiesBase` --|> `notion_date_page_property`:inherits
```

## Remarks

The internal function `ConvertTo-NotionFormattedDateTime` is used to validate the input and convert it to a Notion-formatted DateTime string.

## Related Classes

- [PagePropertiesBase](./00_pp_base.md)
