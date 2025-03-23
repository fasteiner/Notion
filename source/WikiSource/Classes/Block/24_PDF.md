# Block: PDF

[API reference](https://developers.notion.com/reference/block#pdf)

```mermaid
classDiagram
    class PDF_structure {
        [rich_text[]] $caption
        ConvertFromObject()
    }


    
    class notion_PDF_block {
        [notion_blocktype] $type = "pdf"
        [PDF_structure] $pdf
        ConvertFromObject()
    }
    `notion_file` --|> `PDF_structure`:inherits
    `PDF_structure` <.. `notion_PDF_block`:uses
    `notion_block` --|> `notion_PDF_block`:inherits
```

## Related Blocks

- [notion_file](./23_File.md)
- [notion_block](./04_Block.md)
