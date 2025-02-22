class DatabasePropertiesBase {
    #https://developers.notion.com/reference/page-property-values
    [string] $id
    [string] $name
    [notion_database_property_type] $type

    DatabasePropertiesBase() {
        $this.id = $null
        $this.name = $null
        $this.type = $null
    }

    DatabasePropertiesBase([string]$type) {
        $this.id = $null
        $this.name = $null
        $this.type = $type
    }

    DatabasePropertiesBase([string]$id, [string]$name, [notion_database_property_type]$type) {
        $this.id = $id
        $this.name = $name
        $this.type = $type
    }

    static [DatabasePropertiesBase] ConvertFromObject($Value)
    {
        $base_obj = $null
        switch ($Value.type)
        {
            "checkbox" { $base_obj = [notion_checkbox_database_property]::ConvertFromObject($Value); break }
            "created_by" { $base_obj = [notion_created_by_database_property]::ConvertFromObject($Value); break }
            "created_time" { $base_obj = [notion_created_time_database_property]::ConvertFromObject($Value); break }
            "date" { $base_obj = [notion_date_database_property]::ConvertFromObject($Value); break }
            "email" { $base_obj = [notion_email_database_property]::ConvertFromObject($Value); break }
            "files" { $base_obj = [notion_files_database_property]::ConvertFromObject($Value); break }
            "formula" { $base_obj = [notion_formula_database_property]::ConvertFromObject($Value); break }
            "last_edited_by" { $base_obj = [notion_last_edited_by_database_property]::ConvertFromObject($Value); break }
            "last_edited_time" { $base_obj = [notion_last_edited_time_database_property]::ConvertFromObject($Value); break }
            "multi_select" { $base_obj = [notion_multi_select_database_property]::ConvertFromObject($Value); break }
            "number" { $base_obj = [notion_number_database_property]::ConvertFromObject($Value); break }
            "people" { $base_obj = [notion_people_database_property]::ConvertFromObject($Value); break }
            "phone_number" { $base_obj = [notion_phone_number_database_property]::ConvertFromObject($Value); break }
            "relation" { $base_obj = [notion_relation_database_property]::ConvertFromObject($Value); break }
            "rollup" { $base_obj = [notion_rollup_database_property]::ConvertFromObject($Value); break }
            "rich_text" { $base_obj = [notion_rich_text_database_property]::ConvertFromObject($Value); break }
            "select" { $base_obj = [notion_select_database_property]::ConvertFromObject($Value); break }
            "status" { $base_obj = [notion_status_database_property]::ConvertFromObject($Value); break }
            "title" { $base_obj = [notion_title_database_property]::ConvertFromObject($Value); break }
            "url" { $base_obj = [notion_url_database_property]::ConvertFromObject($Value); break }
            "unique_id" { $base_obj = [notion_unique_id_database_property]::ConvertFromObject($Value); break }
            default {
                Write-Error "Unknown property: $($Value.type)" -Category InvalidData -RecommendedAction "Check the type of the property"
            }
        }
        try {
            $base_obj.id = $Value.id
            $base_obj.type = $Value.type
            $base_obj.name = $Value.name
        }
        catch {
            Write-Error "Error setting id and type" -Category InvalidData -RecommendedAction "Check the id and type" -TargetObject $Value
        }
        return $base_obj
    }
}
