class notion_databaseproperties
# https://developers.notion.com/reference/property-object
{
    [string] $Id
    [string] $name
    [string] $description
    [DatabasePropertyType] $type

    # notion_databaseproperties($Id, $name, $description, $type)
    # {
    #     $this.Id          = $Id
    #     $this.name        = $name
    #     $this.description = $description
    #     $this.type        = $type
    # }

    # static [notion_databaseproperties] ConvertFromObject($Value)
    # {
    #     return [notion_databaseproperties]::new($Value.id, $Value.name, $Value.description, [DatabasePropertyType]::ConvertFromObject($Value.type))
    # }
}
