# DatabaseProperty: Relation

[API Reference](https://developers.notion.com/reference/page-property-values#relation)

```mermaid
classDiagram

    class notion_database_relation_base {
        [string] $database_id
        [notion_database_relation_type] $type
        ConvertFromObject()
    }

    class notion_database_single_relation {
        [notion_relation_database_property_structure] $single_property
        ConvertFromObject()
    }

    class notion_database_dual_relation {
        [notion_relation_database_property_structure] $dual_property
        ConvertFromObject()
    }


    class notion_relation_database_property {
        [notion_database_relation_base] $relation
        ConvertFromObject()
    }

    class notion_relation_database_property_structure{

        [string] $database_id
        [string] $synced_property_id
        [string] $synced_property_name
    }

    `DatabasePropertiesBase` --|> `notion_relation_database_property`:inherits
    `notion_database_relation_base` --|> `notion_database_single_relation`:inherits
    `notion_database_relation_base` --|> `notion_database_dual_relation`:inherits
    `notion_relation_database_property` ..> notion_database_relation_base:uses
    `notion_database_single_relation` ..> `notion_relation_database_property_structure`:uses
    `notion_database_dual_relation` ..> `notion_relation_database_property_structure`:uses

```

## Related Classes

- [DatabasePropertiesBase](./00_dp_DatabasePropertiesBase.md)
