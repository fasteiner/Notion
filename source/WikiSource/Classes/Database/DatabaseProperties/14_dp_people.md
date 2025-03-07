# DatabaseProperty: People

[API Reference](https://developers.notion.com/reference/property-object#people)

```mermaid
classDiagram
    class notion_people_database_property {
        [hashtable] $people
        ConvertFromObject()
    }
    `DatabasePropertiesBase` --|> `notion_people_database_property`:inherits
```
