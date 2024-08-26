class pp_database : PageProperties
{
    # [rich_text[]] $title
    # $cover
    # $icon
    # $description
    # $is_inline
    [PSCustomObject]$properties
    $parent
    #TODO
    #[PagePropertyType] $properties

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
