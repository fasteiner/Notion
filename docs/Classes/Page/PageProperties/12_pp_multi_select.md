# PageProperty: Multi_select

[API Reference](https://developers.notion.com/reference/page-property-values#multi-select)

```mermaid
classDiagram
    class notion_multi_select_page_property {
        [notion_multi_select_item[]] $multi_select
        add($color, $name)
        ConvertFromObject()
    }
    `PagePropertiesBase` --|> `notion_multi_select_page_property`:inherits
```

## Related Classes

- [PagePropertiesBase](./00_pp_base.md)
- [notion_multi_select_item](../../General/12_multi_select_item.md)
