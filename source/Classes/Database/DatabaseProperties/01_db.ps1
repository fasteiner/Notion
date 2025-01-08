class notion_databaseproperties : hashtable
# https://developers.notion.com/reference/page-property-values
{
    #[notion_page_property_type] $Type

    notion_databaseproperties()
    {
    }

    static [notion_databaseproperties] ConvertFromObject($Value)
    {
        $pageproperties = [notion_databaseproperties]::new()
        foreach ($key in $Value.PSObject.Properties.Name)
        {
            $pageproperties.Add($key, [DatabasePropertiesBase]::ConvertFromObject($Value.$key))
        }
        return $pageproperties
    }

    [void] Add([object] $Key, [object] $Value)
    {
        if (($value) -and (-not ($Value -is [DatabasePropertiesBase])))
        {
            Write-Error "Value must be of type DatabasePropertiesBase" -Category InvalidType -TargetObject $Value -RecommendedAction "Use a class that inherits from DatabasePropertiesBase"
        }
        # Call the base Add method
        ([hashtable] $this).Add($Key, $Value)
    }
}
