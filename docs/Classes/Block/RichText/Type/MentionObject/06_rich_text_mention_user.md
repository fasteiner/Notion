# Rich_Text: Mention: User

[API Reference](https://developers.notion.com/reference/rich-text#mention)

```mermaid
classDiagram
    class rich_text_mention_user {
        [notion_user] $user
        ConvertFromObject()
    }
    `rich_text_mention_base` --|> `rich_text_mention_user`:inherits
```
