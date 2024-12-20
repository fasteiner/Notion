class created_by_property_base : PropertiesBase
{
    [notion_user] $created_by
    
    created_by_property_base($created_by) : base("created_by")
    {
        if($created_by -eq $null)
        {
            $this.created_by = $null
            return
        }
        if($created_by -is [notion_user])
        {
            $this.created_by = $created_by
        }
        else{
            $this.created_by = [notion_user]::ConvertFromObject($created_by)
        }
    }

    static [created_by_property_base] ConvertFromObject($Value)
    {
        $created_by_obj = [created_by_property_base]::new($Value.created_by)
        return $created_by_obj
    }
}
