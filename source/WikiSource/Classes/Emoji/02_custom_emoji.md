# Emoji: Custom_emoji

[API Reference](https://developers.notion.com/reference/emoji-object#custom-emoji)

```mermaid
classDiagram
    class custom_emoji_structure {
        [string]$id
        [string]$name
        [string]$url
        ConvertfromObject()
    }   
    class notion_custom_emoji {
        [icontype]$type = "custom_emoji"
        [string]$custom_emoji
        ConvertfromObject()
    }
```
