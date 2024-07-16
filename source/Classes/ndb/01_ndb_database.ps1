class ndb_database
{
    # [rich_text[]] $title
    # $cover
    # $icon
    # $description
    # $is_inline
    [PSCustomObject]$properties
    $parent
    #[DBproperties] $properties

    addProperty([string]$name, [object]$value)
    {
        if (!$this.properties)
        {
            $this.properties = [PSCustomObject]@{
                "$name" = $value
            }
        }
    }
}
