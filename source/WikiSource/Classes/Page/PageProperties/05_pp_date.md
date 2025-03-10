# PageProperty: Date

[API Refernce](https://developers.notion.com/reference/page-property-values#date)

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
