class DatabaseProperties
# https://developers.notion.com/reference/property-object
{
    [string] $Id
    [string] $name
    [string] $description
    [DatabasePropertyType] $type

    # DatabaseProperties($Id, $name, $description, $type)
    # {
    #     $this.Id          = $Id
    #     $this.name        = $name
    #     $this.description = $description
    #     $this.type        = $type
    # }

    # static [DatabaseProperties] ConvertFromObject($Value)
    # {
    #     return [DatabaseProperties]::new($Value.id, $Value.name, $Value.description, [DatabasePropertyType]::ConvertFromObject($Value.type))
    # }
}
