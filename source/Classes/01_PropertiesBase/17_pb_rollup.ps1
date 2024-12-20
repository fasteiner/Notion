class rollup_property_base_structure
{
    [notion_property_base_rollup_function_type] $function
    [notion_property_base_rollup_type] $type

    rollup_property_base_structure()
    {
    }

    rollup_property_base_structure ($type_value, $function, $type)
    {
        $this.$type = $type_value
        $this.function = [Enum]::Parse([notion_property_base_rollup_function_type], $function)
        $this.type = [Enum]::Parse([notion_property_base_rollup_type], $type)
    }

    static [rollup_property_base_structure] ConvertFromObject($Value)
    {
        if (!$value.type)
        {
            return $null
        }
        $rollup_structure_obj = $null
        switch ($value.type)
        {
            "array"
            {
                $rollup_structure_obj = [rollup_array_property_base_structure]::ConvertFromObject($Value)
            }
            "date"
            {
                $rollup_structure_obj = [rollup_date_property_base_structure]::ConvertFromObject($Value)
            }
            "incomplete"
            {
                $rollup_structure_obj = [rollup_incomplete_property_base_structure]::ConvertFromObject($Value)
            }
            "number"
            {
                $rollup_structure_obj = [rollup_number_property_base_structure]::ConvertFromObject($Value)
            }
            "unsupported"
            {
                $rollup_structure_obj = [rollup_unsupported_property_base_structure]::ConvertFromObject($Value)
            }
        }
        $rollup_structure_obj.function = [Enum]::Parse([notion_property_base_rollup_function_type], $Value.function)
        $rollup_structure_obj.type = [Enum]::Parse([notion_property_base_rollup_type], $Value.type)
        return $rollup_structure_obj
    }
}

class rollup_array_property_base_structure : rollup_property_base_structure
{
    [Object[]] $array

    rollup_array_property_base_structure()
    {

    }

    rollup_array_property_base_structure($array)
    {
        $this.array = $array
    }

    static [rollup_array_property_base_structure] ConvertFromObject($Value)
    {
        return [rollup_array_property_base_structure]::new($Value.array)
    }
}

class rollup_date_property_base_structure : rollup_property_base_structure
{
    [string] $date

    rollup_date_property_base_structure()
    {

    }

    rollup_date_property_base_structure($date)
    {
        $this.date = ConvertTo-TSNotionFormattedDateTime -InputDate $date -fieldName "date"
    }

    static [rollup_date_property_base_structure] ConvertFromObject($Value)
    {
        return [rollup_date_property_base_structure]::new($Value.date)
    }
}

class rollup_incomplete_property_base_structure : rollup_property_base_structure
{
    [object] $incomplete

    rollup_incomplete_property_base_structure()
    {

    }

    rollup_incomplete_property_base_structure($incomplete)
    {
        $this.incomplete = $incomplete
    }

    static [rollup_incomplete_property_base_structure] ConvertFromObject($Value)
    {
        return [rollup_incomplete_property_base_structure]::new($Value.incomplete)
    }
}

class rollup_number_property_base_structure : rollup_property_base_structure
{
    [int] $number

    rollup_number_property_base_structure()
    {

    }

    rollup_number_property_base_structure($number)
    {
        $this.number = $number
    }

    static [rollup_number_property_base_structure] ConvertFromObject($Value)
    {
        return [rollup_number_property_base_structure]::new($Value.number)
    }
}

class rollup_unsupported_property_base_structure : rollup_property_base_structure
{
    [object] $unsupported

    rollup_unsupported_property_base_structure()
    {

    }

    rollup_unsupported_property_base_structure($unsupported)
    {
        $this.unsupported = $unsupported
    }

    static [rollup_unsupported_property_base_structure] ConvertFromObject($Value)
    {
        return [rollup_unsupported_property_base_structure]::new($Value.unsupported)
    }
}

    


class rollup_property_base : PropertiesBase
{
    [rollup_property_base_structure] $rollup

    rollup_property_base() : base("rollup")
    {
        $this.rollup = [rollup_property_base_structure]::new()
    }

    rollup_property_base($type_value, $function, $type) : base("rollup")
    {
        $this.rollup = [rollup_property_base_structure]::new($type_value, $function, $type)
    }

    static [rollup_property_base] ConvertFromObject($Value)
    {
        $rollup_obj = [rollup_property_base]::new()
        $rollup_obj.rollup = [rollup_property_base_structure]::ConvertFromObject($Value.rollup)
        return $rollup_obj
    }
}
