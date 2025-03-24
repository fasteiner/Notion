# Rich_Text: Mention: Link_preview

[API Reference](https://developers.notion.com/reference/rich-text#mention)

```mermaid
classDiagram
    class rich_text_mention_link_preview {
        [rich_text_mention_type] $type = "link_preview"
        [link_preview_structure] $link_preview
        ConvertFromObject()
    }
    `rich_text_mention_base` --|> `rich_text_mention_link_preview`:inherits
```
