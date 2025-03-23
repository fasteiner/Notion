# Rich_Text: Mention

[API Reference](https://developers.notion.com/reference/rich-text#mention)

```mermaid
classDiagram
    class rich_text_mention_base {
        [rich_text_mention_type] $type
    }

    class rich_text_mention {
        [rich_text_mention_base] $mention
        ToJson()
        ConvertFromObject()
    }
    `rich_text` --|> `rich_text_mention`:inherits
```
