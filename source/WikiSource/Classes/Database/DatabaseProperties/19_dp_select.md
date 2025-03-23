# DatabaseProperty: Select

[API Reference](https://developers.notion.com/reference/property-object#select)

```mermaid
classDiagram
    class notion_select_database_property_structure{
        [notion_select[]] $options
        add($name)
        ConvertFromObject()
    }


    class notion_select_database_property {
        [notion_select_database_property_structure] $select
        ConvertFromObject()
    }
    `notion_select_database_property_structure` <.. `notion_select_database_property`:uses
    `DatabasePropertiesBase` --|> `notion_select_database_property`:inherits
```

## Related Objects

- [DatabasePropertiesBase](./00_dp_DatabasePropertiesBase.md)
- [notion_select](../../General/19_select.md)
