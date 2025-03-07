# DatabaseProperty: Formular

[API Reference](https://developers.notion.com/reference/page-property-values#formula)

```mermaid
classDiagram
    class notion_formula_database_property_structure {
        [string] $expression
        ConvertFromObject()
    }

    class notion_formula_database_property {
        [notion_formula_database_property_structure] $formula
        ConvertFromObject()
    }
    `notion_formula_database_property_structure` <.. `notion_formula_database_property`:uses
    `DatabasePropertiesBase` --|> `notion_formula_database_property`:inherits
```
