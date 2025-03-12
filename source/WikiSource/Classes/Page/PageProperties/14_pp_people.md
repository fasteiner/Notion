# PageProperty: People

[API Reference](https://developers.notion.com/reference/page-property-values#people)

```mermaid
classDiagram
    class notion_people_page_property {
        [notion_people_user[]] $people
        ConvertFromObject()
    }
    `PagePropertiesBase` --|> `notion_people_page_property`:inherits
```
