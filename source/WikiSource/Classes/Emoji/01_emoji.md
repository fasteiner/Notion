# Emoji

[API Reference](https://developers.notion.com/reference/notion_emoji-object)

```mermaid
classDiagram
    class notion_emoji {
        [icontype]$type = "emoji"
        [string]$emoji
        ConvertfromObject()
    }
    `notion_icon` --|> `notion_emoji`:inherits
```

It is also possible to use custom emojis in Notion. See the documentation here: [Custom Emoji](./02_custom_emoji.md)
