class notion_databaseproperties : hashtable
# https://developers.notion.com/reference/page-property-values
{
    #[notion_page_property_type] $Type

    notion_databaseproperties()
    {
    }

    
    [void] Add([object] $Key, [object] $Value)
    {
        if (!$value)
        {
            Write-Error "Value cannot be null" -Category InvalidData -TargetObject $Value -RecommendedAction "Provide a valid DatabasePropertiesBase object or null"
            return
        }
        if (($value) -and (-not ($Value -is [DatabasePropertiesBase])))
        {
            Write-Error "Value must be of type DatabasePropertiesBase" -Category InvalidType -TargetObject $Value -RecommendedAction "Use a class that inherits from DatabasePropertiesBase"
        }
        # Call the base Add method
        ([hashtable] $this).Add($Key, $Value)
    }

    static [notion_databaseproperties] ConvertFromObject($Value)
    {
        $dbproperties = [notion_databaseproperties]::new()
        $propertynames = @()
        if (!$Value)
        {
            return $dbproperties
        }
        if ($Value -is [notion_databaseproperties])
        {
            return $Value
        }
        if ($Value -is [hashtable])
        {
            if ($Value.Keys.count -eq 0)
            {
                return $dbproperties
            }
            $propertynames = $Value.Keys
        }
        else
        {
            $propertynames = Remove-DefaultPropertyNames $Value.PSObject.Properties.Name
        }
        foreach ($key in $propertynames)
        {
            $dbproperties.Add($key, [DatabasePropertiesBase]::ConvertFromObject($Value.$key))
        }
        return $dbproperties
    }
}
