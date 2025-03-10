# File: External_file

[API Reference](https://developers.notion.com/reference/file-object#external-files)

```mermaid
classDiagram
    class notion_external_file_structure {
        [string] $url
        ConvertFromObject()
    }

    class notion_external_file {
        [notion_external_file_structure] $external
        ConvertFromObject()
    }
    `notion_file` --|> `notion_external_file`:inherits
```
