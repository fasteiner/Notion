class notion_number_database_property_structure
{
    [notion_database_property_format_type] $format

    notion_number_database_property_structure()
    {
        $this.format = [notion_database_property_format_type]::number
    }

    notion_number_database_property_structure([notion_database_property_format_type] $format)
    {
        $this.format = $format
    }

    static [notion_number_database_property_structure] ConvertFromObject($Value)
    {
        $notion_number_database_property_structure_obj = [notion_number_database_property_structure]::new()
        $notion_number_database_property_structure_obj.format = [Enum]::Parse([notion_database_property_format_type], $Value.format)
        return $notion_number_database_property_structure_obj
    }

}


class notion_number_database_property : DatabasePropertiesBase
# https://developers.notion.com/reference/property-object#number
{
    [notion_number_database_property_structure] $number

    notion_number_database_property() : base("number")
    {
        $this.number = [notion_number_database_property_structure]::new()
    }

    notion_number_database_property($number) : base("number")
    {
        if ($number -eq $null)
        {
            $this.number = [notion_number_database_property_structure]::new()
        }
        else
        {
            if ($number -is [notion_number_database_property_structure])
            {
                $this.number = $number
            }
            else
            {
                $this.number = [notion_number_database_property_structure]::ConvertFromObject($number)
            }
        }
    }

    static [notion_number_database_property] ConvertFromObject($Value)
    {
        if (!$value -or !$value.number)
        {
            Write-Error "Number property is missing in the provided object." -Category InvalidData -TargetObject $Value
            return $null
        }
        if ($value -is [notion_number_database_property])
        {
            return $value
        }
        $notion_number_database_property_obj = [notion_number_database_property]::new()
        $notion_number_database_property_obj.number = [notion_number_database_property_structure]::ConvertFromObject($Value.number)
        return $notion_number_database_property_obj
    }
}
