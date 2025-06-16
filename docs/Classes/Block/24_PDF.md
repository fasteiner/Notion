# Block: PDF

[API reference](https://developers.notion.com/reference/block#pdf)

```mermaid
classDiagram
   class notion_PDF_block {
        [notion_blocktype] $type = "pdf"
        [notion_file] $pdf
        ConvertFromObject()
    }
    `notion_file` <.. `notion_PDF_block`:uses
    `notion_block` --|> `notion_PDF_block`:inherits
```

## Related Blocks

- [notion_file](./23_File.md)
- [notion_block](./04_Block.md)
