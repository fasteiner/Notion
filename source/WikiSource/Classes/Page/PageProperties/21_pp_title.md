# PageProperty: Title

[API Reference](https://developers.notion.com/reference/page-property-values#title)

```mermaid
classDiagram
    class notion_title_page_property {
        [rich_text[]] $title
        add()
        ConvertFromObject()
    }
    `PagePropertiesBase` --|> `notion_title_page_property`:inherits
```

## Related Classes

- [PagePropertiesBase](./00_pp_base.md)
- [rich_text ](../../Block/RichText/01_Rich_Text.md)
