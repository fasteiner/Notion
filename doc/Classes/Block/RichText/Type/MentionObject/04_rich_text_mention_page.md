# Rich_Text: Mention: Page

[API Reference](https://developers.notion.com/reference/rich-text#mention)

```mermaid
classDiagram
    class rich_text_mention_page_structure {
        [string] $id = ""
        ConvertFromObject()
    }

    class rich_text_mention_page {
        [rich_text_mention_page_structure] $page
        ConvertFromObject()
    }
    `rich_text_mention_base` --|> `rich_text_mention_page`:inherits
```
