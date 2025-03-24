# File

[API Reference File Object](https://developers.notion.com/reference/file-object)

[API Reference Block: File](https://developers.notion.com/reference/block#file)

```mermaid
classDiagram
    class notion_file {
        [notion_filetype]$type
        #caption and name are only used in block/file
        [rich_text[]] $caption = @()
        [string] $name
        ConvertFromObject()
    }
    `notion_icon` --|> `notion_file`:inherits
    `notion_file` --|> `notion_hosted_file`:inherits
    `notion_file` --|> `notion_external_file`:inherits
```

## Related Classes

- [notion_icon](../General/00_icon.md)
- [notion_hosted_file](./02_notion_hosted_file.md)
- [notion_external_file](./03_external_file.md)


## Child Classes

- [notion_hosted_file](./02_notion_hosted_file.md)
- [notion_external_file](./03_external_file.md)
