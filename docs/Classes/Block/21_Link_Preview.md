# Block: Link_preview

[API reference](https://developers.notion.com/reference/block#link-preview)

```mermaid
classDiagram
    class link_preview_structure {
        [string] $url
        ConvertFromObject()
    }

    class notion_link_preview_block {
        [notion_blocktype] $type = "link_preview"
        [link_preview_structure] $link_preview
        ConvertFromObject()
    }
    `link_preview_structure` <.. `notion_link_preview_block`:uses
    `notion_block` --|> `notion_link_preview_block`:inherits
```
