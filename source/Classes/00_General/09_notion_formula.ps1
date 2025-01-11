class notion_formula
{
    [notion_formula_type] $type

    notion_formula([notion_formula_type]$type)
    {
        $this.type = $type
    }

    static [notion_formula] ConvertFromObject($Value)
    {
        $notion_fomula_obj = $null
        switch ($Value.type)
        {
            "boolean"
            {
                $notion_fomula_obj = [notion_formula_boolean]::ConvertFromObject($Value) 
            }
            "date"
            {
                $notion_fomula_obj = [notion_formula_date]::ConvertFromObject($Value) 
            }
            "number"
            {
                $notion_fomula_obj = [notion_formula_number]::ConvertFromObject($Value) 
            }
            "string"
            {
                $notion_fomula_obj = [notion_formula_string]::ConvertFromObject($Value) 
            }
            default
            { 
                Write-Error "Unknown formula type: $($Value.type)" -Category InvalidData -RecommendedAction "Check the formula type and try again. Supported types are boolean, date, number, and string."
            }
        }
        return $notion_fomula_obj
    }
}

class notion_formula_boolean : notion_formula
{
    [bool] $boolean

    notion_formula_boolean([bool]$value) : base([notion_formula_type]::boolean)
    {
        $this.boolean = $value
    }

    static [notion_formula_boolean] ConvertFromObject($Value)
    {
        return [notion_formula_boolean]::new($Value.boolean)
    }
}

class notion_formula_date : notion_formula
{
    [datetime] $date

    notion_formula_date($value) : base([notion_formula_type]::date)
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

    static [notion_formula_date] ConvertFromObject($Value)
    {
        return [notion_formula_date]::new($Value.date)
    }
}

class notion_formula_number : notion_formula
{
    [double] $number

    notion_formula_number([double]$value) : base([notion_formula_type]::number)
    {
        $this.number = $value
    }

    static [notion_formula_number] ConvertFromObject($Value)
    {
        return [notion_formula_number]::new($Value.number)
    }
}

class notion_formula_string : notion_formula
{
    [string] $string

    notion_formula_string([string]$value) : base([notion_formula_type]::string)
    {
        $this.string = $value
    }

    static [notion_formula_string] ConvertFromObject($Value)
    {
        return [notion_formula_string]::new($Value.string)
    }
}
