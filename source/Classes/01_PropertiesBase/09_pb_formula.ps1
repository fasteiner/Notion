class formula_property_base : PropertiesBase
{
    [property_base_formular_type] $type

    formula_property_base([property_base_formular_type]$type) : base("formular")
    {
        $this.type = $type
    }

    static [formula_property_base] ConvertFromObject($Value)
    {
        $notion_fomula_obj = $null
        switch ($Value.type)
        {
            "boolean"
            {
                $notion_fomula_obj = [formula_property_base_boolean]::ConvertFromObject($Value) 
            }
            "date"
            {
                $notion_fomula_obj = [formula_property_base_date]::ConvertFromObject($Value) 
            }
            "number"
            {
                $notion_fomula_obj = [formula_property_base_number]::ConvertFromObject($Value) 
            }
            "string"
            {
                $notion_fomula_obj = [formula_property_base_string]::ConvertFromObject($Value) 
            }
            default
            { 
                Write-Error "Unknown formula type: $($Value.type)" -Category InvalidData -RecommendedAction "Check the formula type and try again. Supported types are boolean, date, number, and string."
            }
        }
        return $notion_fomula_obj
    }
}

class formula_property_base_boolean : formula_property_base
{
    [bool] $boolean

    formula_property_base_boolean([bool]$value) : base([property_base_formular_type]::boolean)
    {
        $this.boolean = $value
    }

    static [formula_property_base_boolean] ConvertFromObject($Value)
    {
        return [formula_property_base_boolean]::new($Value.boolean)
    }
}

class formula_property_base_date : formula_property_base
{
    [datetime] $date

    formula_property_base_date($value) : base([notion_property_base_fomular_type]::date)
    {
        if (!$value)
        {
            $this.date = $null; return 
        }
        if ($value -is [datetime])
        {
            $this.date = $value.ToUniversalTime()
        }
        else
        {
            $this.date = [datetime]::Parse($value).ToUniversalTime()
        }
    }

    static [formula_property_base_date] ConvertFromObject($Value)
    {
        return [formula_property_base_date]::new($Value.date)
    }
}

class formula_property_base_number : formula_property_base
{
    [double] $number

    formula_property_base_number([double]$value) : base([notion_property_base_fomular_type]::number)
    {
        $this.number = $value
    }

    static [formula_property_base_number] ConvertFromObject($Value)
    {
        return [formula_property_base_number]::new($Value.number)
    }
}

class formula_property_base_string : formula_property_base
{
    [string] $string

    formula_property_base_string([string]$value) : base([notion_property_base_fomular_type]::string)
    {
        $this.string = $value
    }

    static [formula_property_base_string] ConvertFromObject($Value)
    {
        return [formula_property_base_string]::new($Value.string)
    }
}


class formula_property_base_page_property : PagePropertiesBase
{
    [formula_property_base] $formula

    formula_property_base_page_property() : base("formula")
    {
    }

    formula_property_base_page_property([formula_property_base]$formula) : base("formula")
    {
        $this.formula = $formula
    }

    static [formula_property_base_page_property] ConvertFromObject($Value)
    {
        $formula_obj = [formula_property_base_page_property]::new()
        $formula_obj.formula = [formula_property_base]::ConvertFromObject($Value.formula)
        return $formula_obj
    }
}
