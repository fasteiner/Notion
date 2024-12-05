class notion_rollup_page_property_structure {
    [notion_page_property_rollup_function_type] $function
    [notion_page_property_rollup_type] $type

    notion_rollup_page_property_structure()
    {

    }

    notion_rollup_page_property ($type_value, $function, $type)
    {
        $this.$type = $type_value
        $this.function = [Enum]::Parse([notion_page_property_rollup_function_type], $function)
        $this.type = [Enum]::Parse([notion_page_property_rollup_type], $type)
    }

    static [notion_rollup_page_property_structure] ConvertFromObject($Value)
    {
        if(!$value.type){
            return $null
        }
        $rollup_structure_obj = $null
        switch ($value.type) {
            "array" {
                $rollup_structure_obj = [notion_rollup_array_page_property_structure]::ConvertFromObject($Value)
            }
            "date" {
                $rollup_structure_obj = [notion_rollup_date_page_property_structure]::ConvertFromObject($Value)
            }
            "incomplete" {
                $rollup_structure_obj = [notion_rollup_incomplete_page_property_structure]::ConvertFromObject($Value)
            }
            "number" {
                $rollup_structure_obj = [notion_rollup_number_page_property_structure]::ConvertFromObject($Value)
            }
            "unsupported" {
                $rollup_structure_obj = [notion_rollup_unsupported_page_property_structure]::ConvertFromObject($Value)
            }
        }
        $rollup_structure_obj.function = [Enum]::Parse([notion_page_property_rollup_function_type], $Value.function)
        $rollup_structure_obj.type = [Enum]::Parse([notion_page_property_rollup_type], $Value.type)
        return $rollup_structure_obj
    }
}

class notion_rollup_array_page_property_structure : notion_rollup_page_property_structure
{
    [Object[]] $array

    notion_rollup_array_page_property_structure()
    {

    }

    notion_rollup_array_page_property_structure($array)
    {
        $this.array = $array
    }

    static [notion_rollup_array_page_property_structure] ConvertFromObject($Value)
    {
        return [notion_rollup_array_page_property_structure]::new($Value.array)
    }
}

class notion_rollup_date_page_property_structure : notion_rollup_page_property_structure
{
    [string] $date

    notion_rollup_date_page_property_structure()
    {

    }

    notion_rollup_date_page_property_structure($date)
    {
        $this.date = ConvertTo-NotionFormattedDateTime -InputDate $date -fieldName "date"
    }

    static [notion_rollup_date_page_property_structure] ConvertFromObject($Value)
    {
        return [notion_rollup_date_page_property_structure]::new($Value.date)
    }
}

class notion_rollup_incomplete_page_property_structure : notion_rollup_page_property_structure
{
    [object] $incomplete

    notion_rollup_incomplete_page_property_structure()
    {

    }

    notion_rollup_incomplete_page_property_structure($incomplete)
    {
        $this.incomplete = $incomplete
    }

    static [notion_rollup_incomplete_page_property_structure] ConvertFromObject($Value)
    {
        return [notion_rollup_incomplete_page_property_structure]::new($Value.incomplete)
    }
}

class notion_rollup_number_page_property_structure : notion_rollup_page_property_structure
{
    [int] $number

    notion_rollup_number_page_property_structure()
    {

    }

    notion_rollup_number_page_property_structure($number)
    {
        $this.number = $number
    }

    static [notion_rollup_number_page_property_structure] ConvertFromObject($Value)
    {
        return [notion_rollup_number_page_property_structure]::new($Value.number)
    }
}

class notion_rollup_unsupported_page_property_structure : notion_rollup_page_property_structure
{
    [object] $unsupported

    notion_rollup_unsupported_page_property_structure()
    {

    }

    notion_rollup_unsupported_page_property_structure($unsupported)
    {
        $this.unsupported = $unsupported
    }

    static [notion_rollup_unsupported_page_property_structure] ConvertFromObject($Value)
    {
        return [notion_rollup_unsupported_page_property_structure]::new($Value.unsupported)
    }
}

    


class notion_rollup_page_property : PagePropertiesBase
# https://developers.notion.com/reference/page-property-values#rollup
{
    [notion_rollup_page_property_structure] $rollup

    notion_rollup_page_property() : base("rollup")
    {
        $this.rollup = [notion_rollup_page_property_structure]::new()
    }

    notion_rollup_page_property($type_value, $function, $type) : base("rollup")
    {
        $this.rollup = [notion_rollup_page_property_structure]::new($type_value, $function, $type)
    }

    static [notion_rollup_page_property] ConvertFromObject($Value)
    {
        $rollup_obj = [notion_rollup_page_property]::new()
        $rollup_obj.rollup = [notion_rollup_page_property_structure]::ConvertFromObject($Value.rollup)
        return $rollup_obj
    }
}
