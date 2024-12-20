class last_edited_by_property_base : PropertiesBase
{
    [notion_user] $last_edited_by

    last_edited_by_property_base($value) : base("last_edited_by")
    {
        if ($value -eq $null)
        {
            $this.last_edited_by = $null
            return
        }
        if ($value -is [notion_user])
        {
            $this.last_edited_by = $value
        }
        else
        {
            $this.last_edited_by = [notion_user]::ConvertFromObject($value)
        }
    }

    static [last_edited_by_property_base] ConvertFromObject($Value)
    {
        return [last_edited_by_property_base]::new($Value.last_edited_by)
    }
}
