# PageProperty: Relation

[API Reference](https://developers.notion.com/reference/page-property-values#relation)

```mermaid
classDiagram
    class notion_relation_page_property {
        [bool] $has_more
        [notion_page_reference[]] $relation
        ConvertFromObject()
    }
    `PagePropertiesBase` --|> `notion_relation_page_property`:inherits
```

## Related Classes

- [PagePropertiesBase](./00_pp_base.md)
- [notion_page_reference](../../Page/04_page_reference.md)
