class PropertiesBase {
    #https://developers.notion.com/reference/page-property-values
    [string] $id
    [notion_property_base_type] $type

    PropertiesBase([notion_property_base_type]$type)
    {
        $this.type = $type
    }

    PropertiesBase([string]$id, [notion_property_base_type]$type)
    {
        $this.id = $id
        $this.type = $type
    }

    static [PropertiesBase] ConvertFromObject($Value)
    {
        $base_obj = $null
        switch ($Value.type)
        {
            "checkbox" { $base_obj = [checkbox_property_base]::ConvertFromObject($Value); break }
            "created_by" { $base_obj = [created_by_property_base]::ConvertFromObject($Value); break }
            "created_time" { $base_obj = [created_time_property_base]::ConvertFromObject($Value); break }
            "date" { $base_obj = [date_property_base]::ConvertFromObject($Value); break }
            "email" { $base_obj = [email_property_base]::ConvertFromObject($Value); break }
            "files" { $base_obj = [files_property_base]::ConvertFromObject($Value); break }
            "formula" { $base_obj = [formula_property_base]::ConvertFromObject($Value); break }
            "last_edited_by" { $base_obj = [last_edited_by_property_base]::ConvertFromObject($Value); break }
            "last_edited_time" { $base_obj = [last_edited_time_property_base]::ConvertFromObject($Value); break }
            "multi_select" { $base_obj = [multi_select_property_base]::ConvertFromObject($Value); break }
            "number" { $base_obj = [number_property_base]::ConvertFromObject($Value); break }
            "people" { $base_obj = [people_property_base]::ConvertFromObject($Value); break }
            "phone_number" { $base_obj = [phone_number_property_base]::ConvertFromObject($Value); break }
            "relation" { $base_obj = [relation_property_base]::ConvertFromObject($Value); break }
            "rollup" { $base_obj = [rollup_property_base]::ConvertFromObject($Value); break }
            "rich_text" { $base_obj = [rich_text_property_base]::ConvertFromObject($Value); break }
            "select" { $base_obj = [select_property_base]::ConvertFromObject($Value); break }
            "status" { $base_obj = [status_property_base]::ConvertFromObject($Value); break }
            "title" { $base_obj = [title_property_base]::ConvertFromObject($Value); break }
            "url" { $base_obj = [url_property_base]::ConvertFromObject($Value); break }
            "unique_id" { $base_obj = [unique_id_property_base]::ConvertFromObject($Value); break }
            "verification" { $base_obj = [verification_property_base]::ConvertFromObject($Value); break }
            default {
                Write-Error "Unknown property: $($Value.type)" -Category InvalidData -RecommendedAction "Check the type of the property"
            }
        }
        $base_obj.id = $Value.id
        $base_obj.type = $Value.type
        return $base_obj
    }
}
