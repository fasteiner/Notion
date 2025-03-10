# PageProperty: Title

[API Refernce](https://developers.notion.com/reference/page-property-values#title)

```mermaid
classDiagram
    class notion_title_page_property {
        [rich_text[]] $title
        add()
        ConvertFromObject()
    }
    `PagePropertiesBase` --|> `notion_title_page_property`:inherits
```
