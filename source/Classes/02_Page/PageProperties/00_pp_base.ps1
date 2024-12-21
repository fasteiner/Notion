class PagePropertiesBase {
    #https://developers.notion.com/reference/page-property-values
    [string] $id
    [notion_page_property_type] $type

    PagePropertiesBase([notion_page_property_type]$type)
    {
        $this.type = $type
    }

    PagePropertiesBase([string]$id, [notion_page_property_type]$type)
    {
        $this.id = $id
        $this.type = $type
    }

    static [PagePropertiesBase] ConvertFromObject($Value)
    {
        $base_obj = $null
        switch ($Value.type)
        {
            "checkbox" { $base_obj = [notion_checkbox_page_property]::ConvertFromObject($Value); break }
            "created_by" { $base_obj = [notion_created_by_page_property]::ConvertFromObject($Value); break }
            "created_time" { $base_obj = [notion_created_time_page_property]::ConvertFromObject($Value); break }
            "date" { $base_obj = [notion_date_page_property]::ConvertFromObject($Value); break }
            "email" { $base_obj = [notion_email_page_property]::ConvertFromObject($Value); break }
            "files" { $base_obj = [notion_files_page_property]::ConvertFromObject($Value); break }
            "formula" { $base_obj = [notion_formula_page_property]::ConvertFromObject($Value); break }
            "last_edited_by" { $base_obj = [notion_last_edited_by_page_property]::ConvertFromObject($Value); break }
            "last_edited_time" { $base_obj = [notion_last_edited_time_page_property]::ConvertFromObject($Value); break }
            "multi_select" { $base_obj = [notion_multi_select_page_property]::ConvertFromObject($Value); break }
            "number" { $base_obj = [notion_number_page_property]::ConvertFromObject($Value); break }
            "people" { $base_obj = [notion_people_page_property]::ConvertFromObject($Value); break }
            "phone_number" { $base_obj = [notion_phone_number_page_property]::ConvertFromObject($Value); break }
            "relation" { $base_obj = [notion_relation_page_property]::ConvertFromObject($Value); break }
            "rollup" { $base_obj = [notion_rollup_page_property]::ConvertFromObject($Value); break }
            "rich_text" { $base_obj = [notion_rich_text_page_property]::ConvertFromObject($Value); break }
            "select" { $base_obj = [notion_select_page_property]::ConvertFromObject($Value); break }
            "status" { $base_obj = [notion_status_page_property]::ConvertFromObject($Value); break }
            "title" { $base_obj = [notion_title_page_property]::ConvertFromObject($Value); break }
            "url" { $base_obj = [notion_url_page_property]::ConvertFromObject($Value); break }
            "unique_id" { $base_obj = [notion_unique_id_page_property]::ConvertFromObject($Value); break }
            "verification" { $base_obj = [notion_verification_page_property]::ConvertFromObject($Value); break }
            default {
                Write-Error "Unknown property: $($Value.type)" -Category InvalidData -RecommendedAction "Check the type of the property"
            }
        }
        try {
            $base_obj.id = $Value.id
            $base_obj.type = $Value.type
        }
        catch {
            Write-Error "Error setting id and type" -Category InvalidData -RecommendedAction "Check the id and type" -TargetObject $Value
        }
        return $base_obj
    }
}
