# PageProperty: Created_by

[API Refernce](https://developers.notion.com/reference/page-property-values#created-by)

```mermaid
classDiagram
    class notion_created_by_page_property {
        [notion_user] $created_by
        ConvertFromObject()
    }
    `PagePropertiesBase` --|> `notion_created_by_page_property`:inherits
```
