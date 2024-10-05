class PageProperties
{
    #[PagePropertyType] $Type

    PageProperties()
    {
    }

    addproperty([string]$PropertyName, $Property)
    {
        $this."$PropertyName" = 1#["$property"]::new($Property)
    }

    # "Ordernumber": {
    #     "id": "C%3E%3FU",
    #     "type": "number",
    #     "number": 10000
    # }

    # addProperty($Property, [string] $type)
    # {
    #     $out = $Property
    #     if ($Property.type)
    #     {
    #         $out = $out | Select-Object -ExcludeProperty "type"
    #     }
    #     $this."$type" += @{
    #         "type" = $type
    #         "$type" = $out
    #     }
    # }
    # addProperty($Property)
    # {
    #     $out = $Property
    #     $type = $Property.type
    #     # remove type property from Property object
    #     if ($Property.type)
    #     {
    #         $out = $out | Select-Object -ExcludeProperty "type"
    #     }
    #     $this."$type" += @{
    #         "type"  = $type
    #         "$type" = $out
    #     }
    # }
    
    static [PageProperties] ConvertFromObject($Properties)
    {
        $PageProperties = [PageProperties]::new()

        #TODO - BUG - Baustelle
        foreach ($PropertyName in $Properties.properties.psobject.properties.name)
        {
            Write-Host "Value: $PropertyName"
            #TODO Jedes property via eigener pp_Class und deren ConvertFromObject methode umwandeln und zuweisen
            #$PageProperties.$PropertyName.type = $Properties.$PropertyName.type
            #$PageProperties.$PropertyName = [pp_$Properties.$PropertyName.type]::ConvertFromObject($Properties.$PropertyName)
            switch ($property)
            {
                'options'
                {
                    [pp_options]::ConvertFromObject() 
                }
                'database'
                {
                    [pp_database]::ConvertFromObject() 
                }
                'checkbox'
                {
                    [pp_checkbox]::ConvertFromObject() 
                }
                'created_by'
                {
                    [pp_created_by]::ConvertFromObject() 
                }
                'created_time'
                {
                    [pp_created_time]::ConvertFromObject() 
                }
                'dateProperty'
                {
                    [pp_dateProperty]::ConvertFromObject() 
                }
                'date'
                {
                    [pp_date]::ConvertFromObject() 
                }
                'email'
                {
                    [pp_email]::ConvertFromObject() 
                }
                'files'
                {
                    [pp_files]::ConvertFromObject() 
                }
                'formula'
                {
                    [pp_formula]::ConvertFromObject() 
                }
                'last_edited_by'
                {
                    [pp_last_edited_by]::ConvertFromObject() 
                }
                'last_edited_time'
                {
                    [pp_last_edited_time]::ConvertFromObject() 
                }
                'multi_select'
                {
                    [pp_multi_select]::ConvertFromObject() 
                }
                'number'
                {
                    [pp_number]::ConvertFromObject() 
                }
                'people'
                {
                    [pp_people]::ConvertFromObject() 
                }
                'phone_number'
                {
                    [pp_phone_number]::ConvertFromObject() 
                }
                'relation'
                {
                    [relation]::ConvertFromObject() 
                }
                'rollup'
                {
                    [pp_rollup]::ConvertFromObject() 
                }
                'nameProperty'
                {
                    [pp_nameProperty]::ConvertFromObject() 
                }
                'select'
                {
                    [pp_select]::ConvertFromObject() 
                }
                'status'
                {
                    [pp_status]::ConvertFromObject() 
                }
                'title'
                {
                    [pp_title]::ConvertFromObject() 
                }
                'textProperty'
                {
                    [pp_]::ConvertFromObject() 
                }
                'text'
                {
                    [pp_text]::ConvertFromObject() 
                }
                'rich_text'
                {
                    [pp_rich_text]::ConvertFromObject() 
                }
                'url'
                {
                    [pp_url]::ConvertFromObject() 
                }
                default
                {
                    Write-Output "Unknown property: $property" 
                }
            }
        }
        return $PageProperties
    }
}
