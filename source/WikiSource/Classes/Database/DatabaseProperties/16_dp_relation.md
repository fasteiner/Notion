# DatabaseProperty: Relation

[API Reference](https://developers.notion.com/reference/page-property-values#relation)

```mermaid
classDiagram
    class notion_database_relation_property {
        [string] $database_id
        [string] $synced_property_id
        [string] $synced_property_name
        ConvertFromObject()
    }

    class notion_database_relation_base {
        [string] $database_id
        [notion_database_relation_type] $type
        ConvertFromObject()
    }

    class notion_database_single_relation {
        [notion_database_relation_property] $single_property
        ConvertFromObject()
    }

    class notion_database_dual_relation {
        [notion_database_relation_property] $dual_property
        ConvertFromObject()
    }


    class notion_relation_database_property {
        [notion_database_relation_base] $relation
        ConvertFromObject()
    }
    `notion_database_relation_base` --|> `notion_database_single_relation`:inherits
    `notion_database_relation_base` --|> `notion_database_dual_relation`:inherits
    `DatabasePropertiesBase` --|> `notion_relation_database_property`:inherits
```
