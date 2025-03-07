# Block: Image

[API reference](https://developers.notion.com/reference/block#image)

```mermaid
classDiagram
    class Image_structure {
        [notion_file] $image
    }
    
    class notion_image_block {
        [notion_blocktype] $type = "image"
        [Image_structure] $image
        ConvertFromObject()
    }
    `Image_structure` <.. `notion_image_block`:uses
    `notion_block` --|> `notion_image_block`:inherits
```
