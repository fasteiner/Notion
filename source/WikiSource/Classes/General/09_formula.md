# PageProperty: Formula

[API Reference](https://developers.notion.com/reference/page-property-values#formula)

```mermaid
classDiagram
    class notion_formula {
        [notion_formula_type] $type
        ConvertFromObject()
    }

    class notion_formula_boolean {
        [bool] $boolean
        ConvertFromObject()
    }

    class notion_formula_date {
        [datetime] $date
        ConvertFromObject()
    }

    class notion_formula_number {
        [double] $number
        ConvertFromObject()
    }

    class notion_formula_string {
        [string] $string
        ConvertFromObject()
    }
    `notion_formula` --|> `notion_formula_boolean`:inherits
    `notion_formula` --|> `notion_formula_date`:inherits
    `notion_formula` --|> `notion_formula_number`:inherits
    `notion_formula` --|> `notion_formula_string`:inherits
```
