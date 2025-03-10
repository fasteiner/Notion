# PageProperty: Rich_text

[API Refernce](https://developers.notion.com/reference/page-property-values#rich-text)

```mermaid
classDiagram
    class notion_rich_text_page_property {
        [rich_text[]] $rich_text
        add($text)
        ConvertFromObject()
    }
    `PagePropertiesBase` --|> `notion_rich_text_page_property`:inherits
```
