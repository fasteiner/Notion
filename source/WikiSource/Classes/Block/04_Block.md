# Block: Block

[API Reference](https://developers.notion.com/reference/block)

```mermaid
classDiagram
    class notion_block {
        $object = "block"
        $id =  $null
        $parent =  $null
        $children
        [string] $created_time
        [notion_user] $created_by
        [string] $last_edited_time
        [notion_user] $last_edited_by
        [bool] $archived =  $false
        [bool] $in_trash =  $false
        [bool] $has_children =  $false
        addChild()
        ConvertFromObject()
    }   
```

## Derived blocks

Other block types are inherited from the generic block.

Within these blocks a inheritance will only visible as class element without all properties.

```mermaid
classDiagram
    class notion_block:::styleClass
```
