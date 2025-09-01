class notion_rollup
# https://developers.notion.com/reference/page-property-values#rollup
{
    [notion_rollup_function_type] $function
    [notion_rollup_type] $type

    notion_rollup()
    {

    }

    notion_rollup ($type_value, $function, $type)
    {
        $this.$type = $type_value
        $this.function = [Enum]::Parse([notion_rollup_function_type], $function)
        $this.type = [Enum]::Parse([notion_rollup_type], $type)
    }

    # Factory method to create a new notion_rollup object
    static [notion_rollup] Create($type, $function, $data = $null)
    {
        $rollup_obj = $null
        switch ($type)
        {
            ([notion_rollup_type]::array)
            {
                if ($null -eq $data)
                {
                    $rollup_obj = [notion_rollup_array]::new()
                }
                else
                {
                    $rollup_obj = [notion_rollup_array]::new($data)
                }
            }
            ([notion_rollup_type]::date)
            {
                if ($null -eq $data)
                {
                    $rollup_obj = [notion_rollup_date]::new()
                }
                else
                {
                    $rollup_obj = [notion_rollup_date]::new($data)
                }
            }
            ([notion_rollup_type]::incomplete)
            {
                if ($null -eq $data)
                {
                    $rollup_obj = [notion_rollup_incomplete]::new()
                }
                else
                {
                    $rollup_obj = [notion_rollup_incomplete]::new($data)
                }
            }
            ([notion_rollup_type]::number)
            {
                if ($null -eq $data)
                {
                    $rollup_obj = [notion_rollup_number]::new()
                }
                else
                {
                    $rollup_obj = [notion_rollup_number]::new($data)
                }
            }
            ([notion_rollup_type]::unsupported)
            {
                if ($null -eq $data)
                {
                    $rollup_obj = [notion_rollup_unsupported]::new()
                }
                else
                {
                    $rollup_obj = [notion_rollup_unsupported]::new($data)
                }
            }
            default
            {
                Write-Error -Message "Unsupported rollup type: $type" -Category InvalidArgument -RecommendedAction "Use a supported rollup type"
                return $null
            }
        }

        $rollup_obj.function = [Enum]::Parse([notion_rollup_function_type], $function)
        $rollup_obj.type = $type
        return $rollup_obj
    }

    # Factory method to convert from generic object to specific notion_rollup derived class
    static [notion_rollup] ConvertFromObject($Value)
    {
        if (!$value.type)
        {
            return $null
        }
        $rollup_obj = $null
        switch ($value.type)
        {
            "array"
            {
                $rollup_obj = [notion_rollup_array]::ConvertFromObject($Value)
            }
            "date"
            {
                $rollup_obj = [notion_rollup_date]::ConvertFromObject($Value)
            }
            "incomplete"
            {
                $rollup_obj = [notion_rollup_incomplete]::ConvertFromObject($Value)
            }
            "number"
            {
                $rollup_obj = [notion_rollup_number]::ConvertFromObject($Value)
            }
            "unsupported"
            {
                $rollup_obj = [notion_rollup_unsupported]::ConvertFromObject($Value)
            }
        }
        $rollup_obj.function = [Enum]::Parse([notion_rollup_function_type], $Value.function)
        $rollup_obj.type = [Enum]::Parse([notion_rollup_type], $Value.type)
        return $rollup_obj
    }
}

class notion_rollup_array: notion_rollup
{
    [Object[]] $array

    notion_rollup_array()
    {

    }

    notion_rollup_array($array)
    {
        $this.array = $array
    }

    static [notion_rollup_array] ConvertFromObject($Value)
    {
        return [notion_rollup_array]::new($Value.array)
    }
}

class notion_rollup_date: notion_rollup
{
    [string] $date

    notion_rollup_date()
    {

    }

    notion_rollup_date($date)
    {
        $this.date = ConvertTo-NotionFormattedDateTime -InputDate $date -fieldName "date"
    }

    static [notion_rollup_date] ConvertFromObject($Value)
    {
        return [notion_rollup_date]::new($Value.date)
    }
}

class notion_rollup_incomplete: notion_rollup
{
    [object] $incomplete

    notion_rollup_incomplete()
    {

    }

    notion_rollup_incomplete($incomplete)
    {
        $this.incomplete = $incomplete
    }

    static [notion_rollup_incomplete] ConvertFromObject($Value)
    {
        return [notion_rollup_incomplete]::new($Value.incomplete)
    }
}

class notion_rollup_number: notion_rollup
{
    [int] $number

    notion_rollup_number()
    {

    }

    notion_rollup_number($number)
    {
        $this.number = $number
    }

    static [notion_rollup_number] ConvertFromObject($Value)
    {
        return [notion_rollup_number]::new($Value.number)
    }
}

class notion_rollup_unsupported: notion_rollup
{
    [object] $unsupported

    notion_rollup_unsupported()
    {

    }

    notion_rollup_unsupported($unsupported)
    {
        $this.unsupported = $unsupported
    }

    static [notion_rollup_unsupported] ConvertFromObject($Value)
    {
        return [notion_rollup_unsupported]::new($Value.unsupported)
    }
}

    
